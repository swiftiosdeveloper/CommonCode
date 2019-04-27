//
//  AreaSplineVC.swift
//  SwiftExampleCode
//
//  Created by JITESH on 27/04/19.
//  Copyright © 2019 JITESH. All rights reserved.
//

import UIKit
import Highcharts
class AreaSplineVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func initAreaSline(){
        let chartView = HIChartView(frame: view.bounds)
        
        let options = HIOptions()
        
        let chart = HIChart()
        chart.type = "areaspline"
        
        let title = HITitle()
        title.text = "Average fruit consumption during one week"
        
        let legend = HILegend()
        legend.layout = "vertical"
        legend.align = "left"
        legend.verticalAlign = "top"
        legend.x = NSNumber(value: 150)
        legend.y = NSNumber(value: 100)
        legend.floating = NSNumber(value: true)
        legend.borderWidth = NSNumber(value: 1)
        legend.backgroundColor = HIColor(hexValue: "FFFFFF")
        
        let xaxis = HIXAxis()
        xaxis.categories = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        let plotband = HIPlotBands()
        plotband.from = NSNumber(value: 4.5)
        plotband.to = NSNumber(value: 6.5)
        plotband.color = HIColor(rgba: 68, green: 170, blue: 213, alpha: 0.2)
        xaxis.plotBands = [plotband]
        
        let yaxis = HIYAxis()
        yaxis.title = HITitle()
        yaxis.title.text = "Fruit unit"
        
        let tooltip = HITooltip()
        tooltip.shared = NSNumber(value: true)
        tooltip.valueSuffix = " units"
        
        let credits = HICredits()
        credits.enabled = NSNumber(value: false)
        
        let plotoptions = HIPlotOptions()
        plotoptions.areaspline = HIAreaspline()
        plotoptions.areaspline.fillOpacity = NSNumber(value: 0.5)
        let areaspline1 = HIAreaspline()
        areaspline1.name = "John"
        areaspline1.data = [NSNumber(value: 3), NSNumber(value: 4), NSNumber(value: 3), NSNumber(value: 5), NSNumber(value: 4), NSNumber(value: 10), NSNumber(value: 12)]
        
        let areaspline2 = HIAreaspline()
        areaspline2.name = "Jane"
        areaspline2.data = [NSNumber(value: 1), NSNumber(value: 3), NSNumber(value: 4), NSNumber(value: 3), NSNumber(value: 3), NSNumber(value: 5), NSNumber(value: 4)]
        
        options.chart = chart
        options.title = title
        options.legend = legend
        options.xAxis = [xaxis]
        options.yAxis = [yaxis]
        options.tooltip = tooltip
        options.credits = credits
        options.plotOptions = plotoptions
        options.series = [areaspline1, areaspline2]
        
        chartView.options = options
        
        view.addSubview(chartView)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
