//
//  RealTimeChartWrapper.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/30/23.
//

import Foundation
import SwiftUI
import UIKit

struct RealTimeChartWrapper : UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> RealTimeChartViewController {
        let realTimeChart = RealTimeChartViewController()
        return realTimeChart
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
