//
//  CycleRunView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/19/23.
//

import SwiftUI

enum cycleRunConstants {
    static let inflatePressure = 15.3
    static let inflateHoldTime = 4.0
    static let deflatePressure = 14.5
    static let deflateHoldTime = 8.0
}

struct CycleRunView: View {
    //access global instance of bleController
    @EnvironmentObject var bleController: BLEController
    
    @State private var startButtonColor: Color!
    @State private var stopButtonColor: Color!
    @State private var statusTextColor: Color!
    @State private var disableActions: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HeaderView(title: "Cycle Run")
                        .offset(y: -120)
                    
                    VStack {
                        //display connection status
                        Text("Device Status: \(bleController.message)")
                            .onReceive(bleController.$connectionStatus, perform: { deviceStatus in
                                self.statusTextColor = (deviceStatus ?? false) ? .green : .red
                                self.startButtonColor = (deviceStatus ?? false) ? Color("GreenTheme") : .gray
                                self.stopButtonColor = (deviceStatus ?? false) ? Color("BlueTheme") : .gray
                                self.disableActions = (deviceStatus ?? false) ? false : true
                            })
                            .bold()
                            .font(.headline)
                            .foregroundColor(statusTextColor)
                            .offset(y:-80)
                        
                        VStack {
                            Button(
                                action: {
                                    bleController.writeOutgoingValue(
                                        freeRun: 0,
                                        inflate: 0,
                                        deflate: 0,
                                        cycleRun: 1,
                                        start: 1,
                                        stop: 0,
                                        pressureValue: Float(cycleRunConstants.inflatePressure),
                                        time: Float(cycleRunConstants.inflateHoldTime)
                                    )
                                },
                                label: {
                                    HStack {
                                        Text("Start")
                                            .bold()
                                            .font(.headline)
                                            .multilineTextAlignment(.center)
                                    }
                                    .frame(width: 120, height: 60)
                                    .foregroundColor(.black)
                                    .background(stopButtonColor)
                                    .cornerRadius(25)
                                }
                            )
                            .offset(y: -10)
                            Button(
                                action: {bleController.writeOutgoingValue(
                                    freeRun: 0,
                                    inflate: 0,
                                    deflate: 0,
                                    cycleRun: 1,
                                    start: 0,
                                    stop: 1,
                                    pressureValue: Float(cycleRunConstants.deflatePressure),
                                    time: Float(cycleRunConstants.deflateHoldTime)
                                )},
                                label: {
                                    HStack {
                                        Text("Stop")
                                            .bold()
                                            .font(.headline)
                                            .multilineTextAlignment(.center)
                                    }
                                    .frame(width: 120, height: 60)
                                    .foregroundColor(.black)
                                    .background(startButtonColor)
                                    .cornerRadius(25)
                                }
                            )
                            .offset(y: 10)
                        }
                        .offset(y: -40)
                    }
                    .disabled(disableActions)
                    .offset(y:10)
                }
                .offset(y:10)
                //swift plot
                VStack {
                    Text("Live Pressure Reading (PSI)")
                        .bold()
                        .font(.headline)
                    if (!disableActions){
                        VStack {
                            RealTimePlotView()
                        }
                    }
                    else {
                        Text("Connect Device in Settings to View Plot")
                            .bold()
                            .italic()
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                }
                .frame(width: 350, height: 200)
                .offset(y:40)
                
                //go to settings
                HStack {
                    NavigationLink(
                        destination: SettingsView(),
                        label: {
                            VStack {
                                Image(systemName: "gear")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.white)
                            }
                            .frame(width: 58, height: 58)
                            .background(Color.black)
                            .cornerRadius(25)
                        }
                    )
                }
                .offset(x: 140, y: 100)
            }//end of VStack
            .navigationBarTitle("Cycle Run", displayMode:.inline)
            .navigationBarHidden(true)
        }//end of NavigationView
        .accentColor(Color(.label))
    }
}

#Preview {
    CycleRunView()
        .environmentObject(BLEController())
}
