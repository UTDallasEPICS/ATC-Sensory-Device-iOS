//
//  CBUUIDs.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 9/17/23.
//

import Foundation
import CoreBluetooth

//class of universally unique identifiers of attributes used in BLE
struct CBUUIDs {
    static let kBLESERVICE_UUID = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
    static let kBLE_CHARACTERISTIC_UUID_TX = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
    static let kBLE_CHARACTERISTIC_UUID_RX = "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"

    static let BLEService_UUID = CBUUID(string: kBLESERVICE_UUID)
    static let BLE_Characteristic_uuid_Tx = CBUUID(string: kBLE_CHARACTERISTIC_UUID_TX)//(Property = Write without response)
    static let BLE_Characteristic_uuid_Rx = CBUUID(string: kBLE_CHARACTERISTIC_UUID_RX)// (Property = Read/Notify)
}
