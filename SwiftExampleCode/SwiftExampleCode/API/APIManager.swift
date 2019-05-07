//
//  APIManager.swift
//  SwiftExampleCode
//
//  Created by JITESH on 25/04/19.
//  Copyright © 2019 JITESH. All rights reserved.
//

import SystemConfiguration
import Alamofire

class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
    
    var bgTask: UIBackgroundTaskIdentifier?

    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
    }
    
    
    
    func makeUploadRequest(withURL url: String, method: HTTPMethod, parameter: [String:Any], success: @escaping (Any)->Void, failure: @escaping (String)->Void) {
        print(method.rawValue, url)
        guard isConnectedToNetwork() else {
            failure("Connect to internet")
            return
        }
        var headers = ["Content-Type":"multipart/form-data"]
        if let oauthUser = ThgCEM.shared.currentUser {
            headers["OAuth-Token"] = oauthUser.accessToken
        }
        
        Alamofire.upload(multipartFormData: { (formData) in
            let fileData = parameter[kFileData] as! Data
            let fieldName = parameter[kFieldName] as! String
            let fileName = parameter[kSelectedFileName] as! String
            let mimeType = parameter[kMIMEType] as! String
            formData.append(fileData, withName: fieldName, fileName: fileName, mimeType: mimeType)
        }, to: url, method: method, headers: headers, encodingCompletion: { (result) in
            switch(result) {
            case .success(let uploadRequest, _, _):
                uploadRequest.responseJSON(completionHandler: { response in
                    let jsonData = response.data
                    switch response.result {
                    case .success(let value):
                        success(value)
                    case .failure(let error):
                        failure(error.localizedDescription)
                    }
                })
            case .failure(let error):
                failure(error.localizedDescription)
            }
        })
    }
    
    
    func cancelAllRequest() {
        Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
            tasks.forEach{ $0.cancel() }
        }
    }
}

