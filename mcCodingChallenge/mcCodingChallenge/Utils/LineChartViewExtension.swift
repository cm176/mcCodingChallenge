//
//  LineChartViewExtension.swift
//  mcCodingChallenge
//
//  Created by Cliff on 9/11/2024.
//

import UIKit
import DGCharts

extension LineChartView {
    func defaultSettings() {
        // disable grid
        self.xAxis.drawGridLinesEnabled = false
        self.leftAxis.drawGridLinesEnabled = false
        self.rightAxis.drawGridLinesEnabled = false
        self.drawGridBackgroundEnabled = false
        
        // disable legend
        self.legend.enabled = false
        
        // disable zoom
        self.pinchZoomEnabled = false
        self.doubleTapToZoomEnabled = false
        
        // remove artifacts around chart area
        self.xAxis.enabled = false
        self.leftAxis.enabled = false
        self.rightAxis.enabled = false
        self.drawBordersEnabled = false
        self.minOffset = 0
    }
    
    func generateDataSet(for dataEntries: [ChartDataEntry]) {
        
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Price")
        lineChartDataSet.colors = [NSUIColor.blue]
        lineChartDataSet.valueColors = [NSUIColor.black]
        lineChartDataSet.valueFont = UIFont.systemFont(ofSize: 12)
        lineChartDataSet.lineWidth = 2.0
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.mode = .linear
        lineChartDataSet.drawValuesEnabled = false
        lineChartDataSet.drawFilledEnabled = true
        lineChartDataSet.drawHorizontalHighlightIndicatorEnabled = false
        lineChartDataSet.drawVerticalHighlightIndicatorEnabled = false
        
        lineChartDataSet.fill = getColor()
        
        let data = LineChartData(dataSet: lineChartDataSet)
        self.data = data
    }
    
    func getColor() -> LinearGradientFill? {
        let mainColor = UIColor.blue.withAlphaComponent(0.5)
        let secondaryColor = UIColor.blue.withAlphaComponent(0)
        let colors = [
            mainColor.cgColor,
            secondaryColor.cgColor,
            secondaryColor.cgColor
        ] as CFArray
        let locations: [CGFloat] = [0, 0.79, 1]
        if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                     colors: colors,
                                     locations: locations) {
            return LinearGradientFill(gradient: gradient, angle: 270)
        }
        
        return nil
    }
}
