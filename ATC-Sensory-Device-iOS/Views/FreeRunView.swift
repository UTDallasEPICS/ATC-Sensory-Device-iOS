//
//  FreeRunView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/19/23.
//

import SwiftUI

struct FreeRunView: View {
    //access global instances
    @EnvironmentObject var bleController: BLEController
    
    @State private var holdTime: Double = 1.0
    @State private var targetPressure: Double = 14.7
    @State private var inflateButtonColor: Color!
    @State private var deflateButtonColor: Color!
    @State private var statusTextColor: Color!
    @State private var opacity: Double = 0.0
    @State private var disableActions: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HeaderView(title: "Free Run")
                        .offset(y: -20)
                    
                    VStack {
                        //display connection status
                        Text("Device Status: \(bleController.message)")
                            .onReceive(bleController.$connectionStatus, perform: { deviceStatus in
                                self.statusTextColor = (deviceStatus ?? false) ? .green : .red
                                self.opacity = (deviceStatus ?? false) ? 0.0 : 1.0
                                self.inflateButtonColor = (deviceStatus ?? false) ? Color("BlueTheme") : .gray
                                self.deflateButtonColor = (deviceStatus ?? false) ? Color("GreenTheme") : .gray
                                self.disableActions = (deviceStatus ?? false) ? false : true
                            })
                            .bold()
                            .font(.headline)
                            .foregroundColor(statusTextColor)
                            .padding(.bottom, 20)
                        
                        VStack {
                            InteractiveSlider(valToSave: $holdTime,
                                              sliderValue: 1.0,
                                              sliderDescription: "Hold Time",
                                              displaySpec: 0,
                                              stepSize: 1,
                                              colorGradient: [.green, .blue],
                                              minValue: 1,
                                              maxValue: 30,
                                              unit: "s"
                            )
                            VStack {
                                InteractiveSlider(valToSave: $targetPressure,
                                                  sliderValue: 14.7,
                                                  sliderDescription: "Target Pressure",
                                                  displaySpec: 1,
                                                  stepSize: 0.1,
                                                  colorGradient: [.green, .yellow, .red],
                                                  minValue: 14.7,
                                                  maxValue: 15.7,
                                                  unit: "psi"
                                )
                                
                                HStack {
                                    Text("**L**")
                                        .offset(x:-110)
                                    Text("**M**")
                                        .offset(x:5)
                                    Text("**H**")
                                        .offset(x:110)
                                }
                                .padding(.top, -50)
                            }
                            .offset(y: -15)
                        }
                        .disabled(disableActions)
                        
                        HStack {
                            //send deflate command
                            Button(
                                action: {
                                    print("Deflate Command, targetPressure:\(targetPressure)")
                                    print("Deflate Command, holdTime:\(holdTime)")
                                    bleController.writeOutgoingValue(
                                        freeRun: true,
                                        inflate: false,
                                        deflate: true,
                                        cycleRun: false,
                                        start: false,
                                        stop: false,
                                        pressureValue: Float(targetPressure),
                                        time: Float(holdTime)
                                    )
                                },
                                label: {
                                    HStack {
                                        Text("Deflate")
                                            .bold()
                                            .font(.headline)
                                            .multilineTextAlignment(.center)
                                    }
                                    .frame(width: 120, height: 60)
                                    .foregroundColor(.black)
                                    .background(deflateButtonColor)
                                    .cornerRadius(25)
                                }
                            )
                            .offset(x:-50)
                            
                            //send inflate command
                            Button(
                                action: {
                                    print("Inflate Command, targetPressure:\(targetPressure)")
                                    print("Inflate Command, holdTime:\(holdTime)")
                                    bleController.writeOutgoingValue(
                                        freeRun: true,
                                        inflate: true,
                                        deflate: false,
                                        cycleRun: false,
                                        start: false,
                                        stop: false,
                                        pressureValue: Float(targetPressure),
                                        time: Float(holdTime)
                                    )
                                },
                                label: {
                                    HStack {
                                        Text("Inflate")
                                            .bold()
                                            .font(.headline)
                                            .multilineTextAlignment(.center)
                                    }
                                    .frame(width: 120, height: 60)
                                    .foregroundColor(.black)
                                    .background(inflateButtonColor)
                                    .cornerRadius(25)
                                }
                            )
                            .offset(x:50)
                        }
                        .offset(y: -40)
                    }
                    .disabled(disableActions)
                    .offset(y:10)
                }
                .offset(y:-10)
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
                .offset(x: 140, y: 10)
            }//end of VStack
            .navigationBarTitle("Free Run", displayMode:.inline)
            .navigationBarHidden(true)
        }//end of NavigationView
        .accentColor(Color(.label))
    }
}

#Preview {
    FreeRunView()
        .environmentObject(BLEController())
}
