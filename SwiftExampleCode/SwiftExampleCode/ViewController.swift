//
//  ViewController.swift
//  SwiftExampleCode
//
//  Created by JITESH on 25/04/19.
//  Copyright © 2019 JITESH. All rights reserved.
//

import UIKit
import Highcharts

class ViewController: UIViewController {

    @IBOutlet weak var chartDual: UIView!
    @IBOutlet weak var chartAreaSpline: UIView!
    @IBOutlet weak var chartLineBar: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.self.
        
        self.initDualAxesLineAndColumnChart()
        self.initAreaSpline()
        self.initLineBarGraph()
    }
    func initLineBarGraph()
    {
        let chartView = HIChartView(frame: view.bounds)
        
        let options = HIOptions()
        
        let chart = HIChart()
        chart.type = "column"
        
        let title = HITitle()
        title.text = "Stacked column chart"
        
        let xaxis = HIXAxis()
        xaxis.categories = ["Apples", "Oranges", "Pears", "Grapes", "Bananas"]
        
        let yaxis = HIYAxis()
        yaxis.min = NSNumber(value: 0)
        yaxis.title = HITitle()
        yaxis.title.text = "Total fruit consumption"
        yaxis.stackLabels = HIStackLabels()
        yaxis.stackLabels.enabled = NSNumber(value: true)
        yaxis.stackLabels.style = HICSSObject()
        yaxis.stackLabels.style.fontWeight = "bold"
        yaxis.stackLabels.style.color = "gray"

        let legend = HILegend()
        legend.align = "right"
        legend.x = NSNumber(value: -30)
        legend.verticalAlign = "top"
        legend.y = NSNumber(value: 25)
        legend.floating = NSNumber(value: true)
        legend.backgroundColor = HIColor(name: "white")
        legend.borderColor = HIColor(hexValue: "ccc")
        legend.borderWidth = NSNumber(value: 1)
        legend.shadow = NSNumber(value: false)
        
        let tooltip = HITooltip()
        tooltip.pointFormat = "{series.name}: {point.y}<br/>Total: {point.stackTotal}"
        tooltip.headerFormat = "<b>{point.x}</b><br/>"
        
        let plotoptions = HIPlotOptions()
        plotoptions.column = HIColumn()
        plotoptions.column.stacking = "normal"
        plotoptions.column.dataLabels = HIDataLabels()
        plotoptions.column.dataLabels.enabled = NSNumber(value: true)
        plotoptions.column.dataLabels.color = HIColor(name: "white")
        plotoptions.column.dataLabels.style = HICSSObject()
        plotoptions.column.dataLabels.style.textOutline = "0 0 3px black"
        
        
        let column1 = HIColumn()
        column1.name = "John"
        column1.data = [NSNumber(value: 5), NSNumber(value: 3), NSNumber(value: 4), NSNumber(value: 7), NSNumber(value: 2)]
        
        let column2 = HIColumn()
        column2.name = "Jane"
        column2.data = [NSNumber(value: 2), NSNumber(value: 2), NSNumber(value: 3), NSNumber(value: 2), NSNumber(value: 1)]
        
        let column3 = HIColumn()
        column3.name = "Joe"
        column3.data = [NSNumber(value: 3), NSNumber(value: 4), NSNumber(value: 4), NSNumber(value: 2), NSNumber(value: 5)]

        options.chart = chart
        options.title = title
        options.xAxis = [xaxis]
        options.yAxis = [yaxis]
        options.legend = legend
        options.tooltip = tooltip
        options.plotOptions = plotoptions
        options.series = [column1, column2, column3]
        
        chartView.options = options
        
        view.addSubview(chartView)
        
    }
    
    func initDualAxesLineAndColumnChart()
    {
        let chartView = HIChartView(frame: chartDual.bounds)
        
        let options = HIOptions()
        
        let chart = HIChart()
        chart.zoomType = "xy"
        
        let title = HITitle()
        title.text = "Average Monthly Temperature and Rainfall in Tokyo"
        let subtitle = HISubtitle()
        subtitle.text = "Source: WorldClimate.com"
        let xaxis = HIXAxis()
        xaxis.categories = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        xaxis.crosshair = HICrosshair()
        
        let yaxis1 = HIYAxis()
        yaxis1.labels = HILabels()
        yaxis1.labels.format = "{value}°C"
        yaxis1.labels.style = HICSSObject()
        yaxis1.labels.style.color = "#434348"
        yaxis1.title = HITitle()
        yaxis1.title.text = "Temperature"
        yaxis1.title.style = HICSSObject()
        yaxis1.title.style.color = "#434348"
        
        let yaxis2 = HIYAxis()
        yaxis2.labels = HILabels()
        yaxis2.labels.format = "{value} mm"
        yaxis2.labels.style = HICSSObject()
        yaxis2.labels.style.color = "#7cb5ec"
        yaxis2.title = HITitle()
        yaxis2.title.text = "Rainfall"
        yaxis2.title.style = HICSSObject()
        yaxis2.title.style.color = "#7cb5ec"
        yaxis2.opposite = NSNumber(value: true)
        
        let tooltip = HITooltip()
        tooltip.shared = NSNumber(value: true)
        
        let legend = HILegend()
        legend.layout = "vertical"
        legend.align = "left"
        legend.x = NSNumber(value: 120)
        legend.verticalAlign = "top"
        legend.y = NSNumber(value: 100)
        legend.floating = NSNumber(value: true)
        legend.backgroundColor = HIColor(hexValue: "FFFFFF")
        
        let column = HIColumn()
        column.name = "Rainfall"
        column.yAxis = NSNumber(value: 1)
        column.data = [NSNumber(value: 49.9), NSNumber(value: 71.5), NSNumber(value: 106.4), NSNumber(value: 129.2), NSNumber(value: 144), NSNumber(value: 176), NSNumber(value: 135.6), NSNumber(value: 148.5), NSNumber(value: 216.4), NSNumber(value: 194.1), NSNumber(value: 95.6), NSNumber(value: 54.4)]
        column.tooltip = HITooltip()
        column.tooltip.valueSuffix = " mm"
        
        let spline = HISpline()
        spline.name = "Temperature"
        spline.data = [NSNumber(value: 7), NSNumber(value: 6.9), NSNumber(value: 9.5), NSNumber(value: 14.5), NSNumber(value: 18.2), NSNumber(value: 21.5), NSNumber(value: 25.2), NSNumber(value: 26.5), NSNumber(value: 23.3), NSNumber(value: 18.3), NSNumber(value: 13.9), NSNumber(value: 9.6)]
        spline.tooltip = HITooltip()
        spline.tooltip.valueSuffix = "°C"
        
        options.chart = chart
        options.title = title
        options.subtitle = subtitle
        options.xAxis = [xaxis]
        options.yAxis = [yaxis1, yaxis2]
        options.tooltip = tooltip
        options.legend = legend
        options.series = [column, spline]
        chartView.options = options
        
        chartDual.addSubview(chartView)

    }
    
    func initAreaSpline()
    {
        let chartView = HIChartView(frame: chartLineBar.bounds)
        
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
        
        chartLineBar.addSubview(chartView)
        
    }

}

