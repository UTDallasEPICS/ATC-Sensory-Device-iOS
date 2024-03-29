//
//  SettingsView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/19/23.
//

import SwiftUI

struct SettingsView: View {
    //access global instance of bleController
    @EnvironmentObject var bleController: BLEController
    @State private var permissionStatus: String = "Unknown"
    @State private var enableButtonColor: Color!
    @State private var statusTextColor: Color!
    @State private var showHints: Bool = false
    
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
                    .padding(.bottom, 5)
                
                Text("Device Status: \(bleController.message)")
                    .onReceive(bleController.$connectionStatus, perform: { deviceStatus in
                        self.statusTextColor = (deviceStatus ?? false) ? .green : .red
                        self.showHints = (deviceStatus ?? false) ? false : true
                    })
                    .bold()
                    .font(.headline)
                    .foregroundColor(statusTextColor)
                    .padding(.bottom, 5)
                
                if (showHints){
                    Text("Hint: Check to make sure the device is on")
                        .bold()
                        .italic()
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
                
                
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
        .environmentObject(BLEController())
}

/*
 @StateObject should be used only once per object. In this case, the settingsview is responsible for creating the object. Free run and cycle run views should be @ObservedObject
 */
