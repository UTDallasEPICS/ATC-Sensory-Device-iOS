//
//  BLEController.swift
//  ATC-Sensory-Device-iOS
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
    @Published var peripheralState: String = "N/A"
    private var cuffPeripheral: CBPeripheral!       //create instance of peripheral
    private var txCharacteristic: CBCharacteristic!
    private var rxCharacteristic: CBCharacteristic!
        
    override init(){
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    //is device is on? scan for peripherals.
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff:
            print("Is powered off")
        case .poweredOn:
            print("Is powered on")
            connectToSensor()
        case .unsupported:
            print("Is unsupported")
            peripheralState = "Unsupported"
        case .unauthorized:
            print("Is unauthorized")
            peripheralState = "Disabled"
        case .unknown:
            print("Is unknown")
            peripheralState = "Unknown"
        case .resetting:
            print("Resetting")
            peripheralState = "Resetting"
        @unknown default:
            peripheralState = "Error"
            print("Error")
        }
    }
    
    //scan for peripherals
    func connectToSensor(){
        centralManager.scanForPeripherals(withServices: [CBUUIDs.BLEService_UUID], options: nil)
        print("Connected")
    }
    
    //disconnect or cancel an active or pending local connection
    func disconnectFromSensor(){
        if cuffPeripheral != nil {
            centralManager.cancelPeripheralConnection(cuffPeripheral!)
        }
        print("Disconnected")
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
        if let floatValue = characteristic.value?.withUnsafeBytes({ $0.load(as: Float.self) }){
            print(floatValue)
        }
        else {
            print("Data is not suitable for conversion to a float.")
        }
     }
    
    //write characteristic
    func writeOutgoingValue(value: Float) {
        //create mutable version of value
        var floatValue = value
        
        //a float is 32 bits, so create a pointer to the value byte array with UnsafeBufferPointer and place it in the Data object
        //this line generates a warning about dangling buffer pointers. as long as the pointer is not access elsewhere,
        //safety is maintained
        let floatBytes = Data(buffer: UnsafeBufferPointer(start: &floatValue, count:1))
        
        print(floatBytes as NSData)
        
        if let cuffPeripheral = cuffPeripheral{
        //enter block if cuffPeripheral exists i.e. is not nil
            if let txCharacteristic = txCharacteristic {
            //enter block if txCharacteristic is not nil
                cuffPeripheral.writeValue(((floatBytes as NSData) as Data), for: txCharacteristic, type: CBCharacteristicWriteType.withResponse)
                
            }
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
 for getting a pointer to buffer: stackoverflow.com/questions/36812583/how-to-convert-a-float-value-to-byte-array-in-swift
 */