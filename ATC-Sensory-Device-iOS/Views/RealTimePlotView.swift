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
    static let dataArrayLength = 10
    static let magnitudeLimit: Float = 15.3
}
struct RealTimePlotView: View {
    //access global instance of bleController
    @EnvironmentObject var bleController: BLEController
    
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
            .onReceive(timer, perform: updateData)
            .chartYScale(domain: 0...Constants.magnitudeLimit)
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
            //data.append(bleController.currPressureValue)
            data.append(Float.random(in: 0...Constants.magnitudeLimit))
        }
    }
}



#Preview {
    RealTimePlotView()
}
