//
//  RealTimePlotView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/30/23.
//

import SwiftUI
import Charts

enum PlotViewConstants {
    static let dataArrayLength = 20
    static let magnitudeMaximum: Float = 16.0
    static let magnitudeMinimum: Float = 14.0
}

struct RealTimePlotView: View {
    //access global instance of bleController
    @EnvironmentObject var bleController: BLEController
    
    //unwrap published value
    @State private var unwrappedPressureValue: Float = 0.0
    
    //assign array and populate with zeros
    @State var data: [Float] = Array(repeating: 0, count: PlotViewConstants.dataArrayLength)
    
    var body: some View {
        VStack{
            Chart(Array(data.enumerated()), id: \.0)
            { index, magnitude in
                LineMark(x: .value("Time", String(index)), y: .value("Magnitude", magnitude))
                    .foregroundStyle(Color("BlueTheme"))
            }
            
            //value updates every time it is recieved from bleController
            .onReceive(bleController.$currPressureValue,
                       perform: {value in
                data.removeFirst()
                self.unwrappedPressureValue = value
                withAnimation(.easeOut(duration: 0.08)){
                    data.append(unwrappedPressureValue)
//                    DEBUGGING ONLY:
//                    data.append(Float.random(in: 14.7...15.7))
                }
            }
            )
            .chartYScale(domain: PlotViewConstants.magnitudeMinimum...PlotViewConstants.magnitudeMaximum)
            .chartYAxis{
                AxisMarks(position: .leading,
                          stroke: StrokeStyle(lineWidth: 0))
            }
            .chartXAxis(.hidden)
            .frame(height: 200)
        }
    }
}

#Preview {
    RealTimePlotView()
}

/*
 Source(s):
 Vinicius Nakamura
 https://github.com/vNakamura/SwiftChartsAudioVisualizer.git
 www.youtube/com/watch?v=8kX1CX-ujlA
 for logic about queue:
 https://medium.com/@daniel_liao/the-easiest-way-to-build-real-time-chart-in-ios-fb25bbe35ba1
 */
