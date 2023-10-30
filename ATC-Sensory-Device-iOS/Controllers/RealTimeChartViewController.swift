//
//  RealTimeChartViewController.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/29/23.
//

import Foundation
#if canImport(UIKit)
    import UIKit
#endif
import DGCharts

class RealTimeChartViewController: UIViewController, SourceViewControllerDelegate {

    let chartView = LineChartView()
    var dataEntries = [ChartDataEntry]()
    var pressureValue: Double = 0.0
    
    //set how many dataentries show up in chartView
    var xValue: Double = 10
    
    func dataToPass(_ data: Float) {
        pressureValue = Double(data)
        print("Data passed via delegate: \(pressureValue)")
    }
    
    //add LineChartView
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupInitialDataEntries()
        setupChartData()
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(didUpdatedChartView), userInfo: nil, repeats: true)
    }
    
    @objc func didUpdatedChartView(){
        let newDataEntry = ChartDataEntry(x: xValue,
                                          y: pressureValue)
        updateChartView(with: newDataEntry, dataEntries: &dataEntries)
        xValue += 1
    }
    
    func setupViews(){
        view.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chartView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        chartView.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        chartView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    //set initial data entries
    func setupInitialDataEntries(){
        (0..<Int(xValue)).forEach {
            let dataEntry = ChartDataEntry(x: Double($0), y: 0)
            dataEntries.append(dataEntry)
        }
    }
    
    //add ChartData to LineChartView
    func setupChartData(){
        /*
         * Initialize LineChartDataSet instance using dataEntries
         * label the plot, disable drawCircles, set color, and set the dataSet mode
         */
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "set 1")
        chartDataSet.drawCirclesEnabled = false
        chartDataSet.setColor(.systemMint)
        chartDataSet.mode = .linear
        
        /*
         * Intialize LineChartData instance using chartDataSet and set chartView.data equal to chartData
         * set x-axis position to bottom
         */
        let chartData = LineChartData(dataSet: chartDataSet)
        chartView.data = chartData
        chartView.xAxis.labelPosition = .bottom
    }
    
    /*
     Activate Chart View: Generally, imagine dataSet as a queue. to add the dataEntry at the end you need to remove the first dataEntry
     1. Find the first dataEntry (oldDataEntry) in dataEntries, remove oldEntry at dataEntries and chartView.data
     2. Add new DataEntry(newDataEntry) into dataEntries and chartView.data
     3. Notify the dataSet has been changed and move the dataSet to the new xValue
     */
    func updateChartView(with newDataEntry: ChartDataEntry, dataEntries: inout [ChartDataEntry]){
        //1
        if let oldEntry = dataEntries.first {
            dataEntries.removeFirst()
            chartView.data?.removeEntry(oldEntry, dataSetIndex: 0)
        }
        
        //2
        dataEntries.append(newDataEntry)
        chartView.data?.appendEntry(newDataEntry, toDataSet: 0)
        
        
        //3
        chartView.notifyDataSetChanged()
        chartView.animate(xAxisDuration: 0.000001, yAxisDuration: 0.000001)
        chartView.moveViewToX(newDataEntry.x)
        
    }
}
