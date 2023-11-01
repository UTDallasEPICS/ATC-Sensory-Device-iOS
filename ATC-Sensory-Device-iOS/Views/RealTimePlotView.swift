//
//  RealTimePlotView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/30/23.
//

import SwiftUI
import Charts

enum Constants {
    static let updateInterval = 0.30
    static let dataArrayLength = 12
    static let magnitudeMaximum: Float = 16.0
    static let magnitudeMinimum: Float = 14.0
}

struct RealTimePlotView: View {
    //access global instance of bleController
    @EnvironmentObject var bleController: BLEController
    
    //unwrap published value
    @State private var unwrappedPressureValue: Float = 0.0
    
    let timer = Timer.publish(
        every: Constants.updateInterval,
        on: .main,
        in: .common
    ).autoconnect()
    
    //assign array with random values to begin with
    @State var data: [Float] = Array(repeating: 0, count: Constants.dataArrayLength)
    
    var body: some View {
        VStack{
            Chart(Array(data.enumerated()), id: \.0)
            { index, magnitude in
                LineMark(x: .value("Frequency", String(index)), y: .value("Magnitude", magnitude))
                    .foregroundStyle(Color("BlueTheme"))
            }
            //value updates every time it is recieved from bleController
            .onReceive(bleController.$currPressureValue,
                       perform: {value in self.unwrappedPressureValue = value}
                      )
            //update function is called only when timer updates. value of unwrappedPressureVal at the time timer updates is counted
            .onReceive(timer, perform: updateData)
            .chartYScale(domain: Constants.magnitudeMinimum...Constants.magnitudeMaximum)
            .chartYAxis{
                AxisMarks(position: .leading,
                          stroke: StrokeStyle(lineWidth: 0))
            }
            .chartXAxis(.hidden)
            .frame(height: 200)
        }
    }
    
    //treat the array as a queue. dequeue the first value to enqueue the new value
    //when you recieve a new timer value, add currPressureValue to data
    func updateData(_: Date) {
        //remove first entry
        data.removeFirst()
        
        //append new entry
        withAnimation(.easeOut(duration: 0.08)){
            data.append(unwrappedPressureValue)
            //FOR DEBUGGING ONLY
//            data.append(Float.random(in: Constants.magnitudeMinimum...Constants.magnitudeMaximum))
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
