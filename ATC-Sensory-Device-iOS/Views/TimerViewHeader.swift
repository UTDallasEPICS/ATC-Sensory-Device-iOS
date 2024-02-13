//
//  TimerViewHeader.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 2/12/24.
//

import SwiftUI

struct TimerViewHeader: View {
    let minutesElapsed: Int
    let minutesRemaining: Int
    
    private var totalMinutes: Int{
        minutesElapsed + minutesRemaining
    }
    
    private var progress: Double {
        guard totalMinutes > 0 else { return 1}
        return Double(minutesElapsed)/Double(minutesRemaining)
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .tint(Color.teal)
            
            HStack{
                VStack(alignment: .leading){
                    Text("Elapsed")
                        .font(.headline)
                    Label("\(minutesElapsed) min", systemImage: "hourglass.tophalf.fill")
                        .labelStyle(.leadingIcon)
                }
                Spacer()
                VStack(alignment: .trailing){
                    Text("Remaining")
                        .font(.headline)
                    Label("\(minutesRemaining) min", systemImage: "hourglass.bottomhalf.fill")
                        .labelStyle(.trailingIcon)
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time Remaining")
        .accessibilityValue("\(minutesRemaining) minutes")
        .padding([.top, .horizontal])
    }
}

#Preview {
    TimerViewHeader(minutesElapsed: 10, minutesRemaining: 5)
        .previewLayout(.sizeThatFits)
}
