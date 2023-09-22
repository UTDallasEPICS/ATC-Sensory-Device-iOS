//
//  BLEController.swift
//  ATC Sensory Cuff
//
//  Created by UTDesign on 9/17/23.
//

import Foundation
import CoreBluetooth

/*
 *Class that has methods to connect to a sensor, scan and connect to peripherals,
 *discover services, characteristics, and read value for a characteristic
 */
class BLEController: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate{
    @Published var centralManager: CBCentralManager!//create instance of central manager
    private var cuffPeripheral: CBPeripheral!       //create instance of peripheral
    private var txCharacteristic: CBCharacteristic!
    private var rxCharacteristic: CBCharacteristic!
        
    override init(){
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    //is device is on, scan for peripherals.
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff:
            print("Is powered off")
        case .poweredOn:
            print("Is powered on")
            connectToSensor()
        case .unsupported:
            print("Is unsupoported")
        case .unauthorized:
            print("Is unauthorized")
        case .unknown:
            print("Is unknown")
        case .resetting:
            print("Resetting")
        @unknown default:
            print("Error")
        }
    }
    
    //scan for peripherals
    func connectToSensor(){
        centralManager.scanForPeripherals(withServices: [CBUUIDs.BLEService_UUID], options: nil)
    }
    
    //disconnect or cancel an active or pending local connection
    func disconnectFromDevice(){
        if cuffPeripheral != nil {
            centralManager.cancelPeripheralConnection(cuffPeripheral!)
        }
    }
        
    //assign a local peripheral
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        cuffPeripheral = peripheral                       //set cuffPeripheral variable to new peripheral found
        cuffPeripheral.delegate = self                    //
        print("Peripheral Discovered: \(peripheral)")     //print new peripheral's information in console
        print("Peripheral Name: \(String(describing: peripheral.name) )")
        print("Advertisement Data: \(advertisementData)")
        
        //stop scanning for peripherals
        centralManager.stopScan()
        centralManager.connect(cuffPeripheral!, options: nil)
    }
    
    //discover services
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        cuffPeripheral.discoverServices([CBUUIDs.BLEService_UUID])
    }
    
    //handle and filter services if there is no error
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?){
        print("**********************************************************")
        if ((error) != nil){
            print("Error discovering services: \(error!.localizedDescription)")
            return
        }
        guard let services = peripheral.services else {
            return
        }
        //discover all characteristics
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
            print("Discovered Services: \(services)")
        }
    }
    
    //discover characteristics
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else{
            return
        }
        print("Found \(characteristics.count) characteristics.")
        
        for characteristic in characteristics {
            if characteristic.uuid.isEqual(CBUUIDs.BLE_Characteristic_uuid_Rx){
                rxCharacteristic = characteristic
                
                //set notify value allows you to recieve data from the peripheral
                peripheral.setNotifyValue(true, for: rxCharacteristic!)
                peripheral.readValue(for: characteristic)
                print("rx Characteristic: \(rxCharacteristic.uuid)")
            }
            if characteristic.uuid.isEqual(CBUUIDs.BLE_Characteristic_uuid_Tx){
                txCharacteristic = characteristic
                print("tx Characteristic: \(rxCharacteristic.uuid)")
            }
        }
    }
    
    //start communicating with bluetooth device
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager){
        switch peripheral.state {
        case .poweredOn:
            print("Peripheral is powered on")
            break
        case .unsupported:
            print("Peripheral is unsupported")
            break
        case .unauthorized:
            print("Peripheral unknown")
            break
        case .resetting:
            print("Peripheral resetting")
            break
        case .poweredOff:
            print("Peripheral is powered off")
            break
        case .unknown:
            print("Error. Unknown peripheral state")
        @unknown default:
            print("Error. Unknown peripheral state")
        }
    }
    
    //read characteristic
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?){
        var characteristicASCIIValue = NSString()
        guard characteristic == rxCharacteristic,
              let characteristicValue = characteristic.value,
              let ASCIIstring = NSString(data: characteristicValue, encoding: String.Encoding.utf8.rawValue) else { return }
        characteristicASCIIValue = ASCIIstring
        print("Value Recieved: \(characteristicASCIIValue as String)")
    }
    
    //write characteristic
    func writeOutgoingValue(value: Float){
        print(value)
        //convert float value to an IEEE standard 32 bit array
        var valueBytes = convertToUInt32Array(value)
        //Data is a byte buffer in memory
        let valuePtr = Data(buffer: UnsafeBufferPointer(start: &valueBytes, count: 1))
        if let cuffPeripheral = cuffPeripheral{
            if let txCharacteristic = txCharacteristic {
                cuffPeripheral.writeValue(valuePtr, for: txCharacteristic, type: CBCharacteristicWriteType.withResponse)
            }
        }
    }
    
    private func convertToUInt32Array(_ value: Float)->[UInt32]{
        var floatValue = value; //make a mutable copy
        return withUnsafeBytes(of: &floatValue){(ptr: UnsafeRawBufferPointer)->[UInt32] in
            let uint32Ptr = ptr.bindMemory(to: UInt32.self)
            return Array(uint32Ptr)
        }
    }
}




/*Notes
 *Core Bluetooth framework - provides classes to communicate with BLEs
 *CBCentralManager object - scans for, discoveres, connects to, manages peripherals
 *CBPeripheral object - represents remote peripherals that app discovers with a central manager. discovers, explores, and interacts with services available on remote peripheral
 *Service - encapsulates the way part of the device behaves
 *Characteristics - services contain characteristics or included services i.e references to other services
 *an ! at the end of a type indicates that a variable is initially empty or has no value.
     You're promising that you'll set a value before trying to use it
 *
 */

/*Sources
 learn.adafruit.com/build-a-bluetooth-app-using-swift-5?view=all
 novelbits.io/manage-multiple-ble-peripherals-in-ios-swiftui/
 */
