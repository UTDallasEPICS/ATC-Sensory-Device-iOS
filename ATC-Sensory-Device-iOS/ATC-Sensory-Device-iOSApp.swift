//
//  ATC_Sensory_CuffApp.swift
//  ATC Sensory Cuff
//
//  Created by UTDesign on 9/17/23.
//

import SwiftUI

//insert views into this page
@main
struct ATC_Sensory_CuffApp: App {
    @StateObject var bleController = BLEController()
    @StateObject private var store = UserStore()
    
    var body: some Scene {
        WindowGroup {
            //Main app entry point is a splash screen
            WelcomeScreenView()
                .environmentObject(bleController)
                .environmentObject(store)
                
        }
    }
}

