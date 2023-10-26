//
//  RealTimePlotView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/24/23.
//

import SwiftUI
import Charts

struct RealTimePlotView: View {
    //access global instance of bleController
    @EnvironmentObject var bleController: BLEController
    
    //create array variable for line mark data
    @State private var lineMarkData: [(Float, Float)]!
    
    var body: some View {
        Text("Hello World")
    }
}

#Preview {
    RealTimePlotView()
        .environmentObject(BLEController())
}
