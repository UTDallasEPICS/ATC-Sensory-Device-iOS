//
//  TimerView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 2/8/24.
//

import SwiftUI

struct TimerView: View {
    @StateObject var runTimer = RunTimer()
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20.0)
                .fill(Color.white)
            VStack {
                TimerViewHeader(minutesElapsed: runTimer.minutesElapsed,
                                minutesRemaining: runTimer.minutesRemaining)
                Circle()
                    .strokeBorder(lineWidth: 24)
            }
        }
        .padding()
        .foregroundColor(Color("BlueTheme"))
        .onAppear{
            runTimer.reset(lengthInMinutes: 15)
            runTimer.startRun()
        }
        .onDisappear{
            runTimer.stopRun()
        }
    }
}

#Preview {
    TimerView()
}
