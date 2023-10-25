//
//  CycleRunView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/19/23.
//

import SwiftUI

struct CycleRunView: View {
    @EnvironmentObject var bleController: BLEController
    @State private var startButtonColor: Color!
    @State private var stopButtonColor: Color!
    @State private var statusTextColor: Color!
    @State private var opacity: Double = 0.0
    @State private var disableActions: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "Cycle Run")
                    .offset(y: -120)
                
                VStack {
                    //display connection status
                    Text("Device Status: \(bleController.message)")
                        .onReceive(bleController.$connectionStatus, perform: { deviceStatus in
                            self.statusTextColor = (deviceStatus ?? false) ? .green : .red
                            self.opacity = (deviceStatus ?? false) ? 0.0 : 1.0
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
                            action: {/*NEEDS TO BE COMPLETED. WRITE TO ESP*/},
                            label: {
                                HStack {
                                    Text("Start")
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
                        .offset(y: -10)
                        Button(
                            action: {/*NEEDS TO BE COMPLETED. WRITE TO ESP*/},
                            label: {
                                HStack {
                                    Text("Stop")
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
                        .offset(y: 10)
                    }
                    .offset(y: -40)
                }
                .disabled(disableActions)
                .offset(y:10)
                
                //swift plot
                RealTimePlotView()
                    .offset(y:50)
                
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
                .offset(x: 140, y: 110)
            }//end of VStack
            .navigationBarTitle("Free Run", displayMode:.inline)
            .navigationBarHidden(true)
        }//end of NavigationView
        .accentColor(Color(.label))
    }
}

#Preview {
    CycleRunView()
}
