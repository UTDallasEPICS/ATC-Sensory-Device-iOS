//
//  SettingsView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/19/23.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var bleController = BLEController()
    
    //default status
    @State var status: String = "Unknown"
    
    //default button color
    @State var statusButtonColor: Color = .gray
    
    var body: some View {
        HeaderView(title: "Settings")
            .offset(y: -245)
        
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
                        Text("**Bluetooth \(status)**")
                            .onReceive(bleController.$isBluetoothPermissionGranted,
                                       perform: { isGranted in
                                self.status = isGranted ?? false ? "Enabled" : "not Enabled"
                                self.statusButtonColor = isGranted ?? false ? Color("BlueTheme") : .red
                            })
                            .font(.system(size: 22))
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 348, height: 85)
                    .background(statusButtonColor)
                    .cornerRadius(25)
                }
            )
            Text("Hint: Click to open iOS Settings App")
                .italic()
                .foregroundColor(.gray)
                .font(.footnote)
        }
        .foregroundColor(.black)
        .offset(y:-215)
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
