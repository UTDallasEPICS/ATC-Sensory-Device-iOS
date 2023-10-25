//
//  SettingsView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/19/23.
//

import SwiftUI

struct SettingsView: View {
    //allows us to view @Published properties
    @EnvironmentObject var bleController: BLEController
    @State private var permissionStatus: String = "Unknown"
    @State private var enableButtonColor: Color!
    
    var body: some View {
        VStack {
            HeaderView(title: "Settings")
                .offset(y:-150)
            
            VStack {
                Text("App Permissions")
                    .bold()
                    .font(.title)
                
                Button(
                    action: {self.openDeviceSettings()},
                    label: {
                        HStack {
                            Image(systemName: "arrow.up.forward.app.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45, height: 45)
                                .offset(x: -20)
                            Text("**Bluetooth \(permissionStatus)**")
                                .onReceive(bleController.$isBluetoothPermissionGranted,
                                           perform: { isGranted in
                                    self.permissionStatus = isGranted ?? false ? "Enabled" : "not Enabled"
                                    self.enableButtonColor = isGranted ?? false ? Color("BlueTheme") : .red
                                })
                                .font(.system(size: 22))
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 348, height: 85)
                        .background(enableButtonColor)
                        .cornerRadius(25)
                    }
                )
                Text("Hint: Click to open iOS Settings App")
                    .italic()
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
            .foregroundColor(.black)
            .offset(y:-80)
            
            
            VStack {
                Text("App Actions")
                    .bold()
                    .font(.title)
                
                Text("Hint: Check to make sure the device is on")
                    .bold()
                    .italic()
                    .font(.headline)
                
                VStack {
                    //connect to device
                    Button(
                        action: {bleController.connectSensor()},
                        label: {
                            HStack {
                                Image(systemName: "wifi")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .offset(x: -20)
                                Text("Connect Device")
                                    .bold()
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(width: 250, height: 70)
                            .foregroundColor(.black)
                            .background(Color("BlueTheme"))
                            .cornerRadius(25)
                        }
                    )
                    .padding(.bottom, 10)
                    //disconnect from to device
                    Button(
                        action: {bleController.disconnectSensor()},
                        label: {
                            HStack {
                                Image(systemName: "wifi.slash")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .offset(x: -10)
                                Text("Disconnect Device")
                                    .bold()
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(width: 250, height: 70)
                            .foregroundColor(.black)
                            .background(Color("GreenTheme"))
                            .cornerRadius(25)
                        }
                    )
                }
            }
            .offset(y:-25)
        }
    }
    
    private func openDeviceSettings(){
        if let url = URL(string: UIApplication.openSettingsURLString){
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }//end of function
    
}

#Preview {
    SettingsView()
}

/*
 @StateObject should be used only once per object. In this case, the settingsview is responsible for creating the object. Free run and cycle run views should be @ObservedObject
 */
