//
//  RealTimePlotView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/24/23.
//

import SwiftUI
import Charts

struct RealTimePlotView: View {
    var body: some View {
        Text("Real-Time Pressure Reading (PSI)")
            .italic()
            .bold()
            .frame(width: 300, height: 200)
            .border(.red)
    }
}

#Preview {
    RealTimePlotView()
}
