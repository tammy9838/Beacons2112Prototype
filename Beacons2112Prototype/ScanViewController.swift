//
//  ScanViewController.swift
//  Beacons2112Prototype
//
//  Created by incloud company on 6/17/2559 BE.
//  Copyright © 2559 incloud. All rights reserved.
//

import UIKit
import CoreBluetooth

class ScanViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    //Declare CentralManager and Peripheral
    var centralManager: CBCentralManager!
    var discoveredPeripheral: CBPeripheral!
    
    //Decalre Service and Characteristic UUID
    var beaconServiceUUID: CBUUID!
    var beaconUUIDCharacteristicUUID: CBUUID!
    var majorMinorCharacteristicUUID: CBUUID!
    //var rssiCharacteristicUUID : CBUUID!
    
    //Declare Characteristic
    var majorMinorCharacteristic : CBCharacteristic!
    var beaconUUIDCharacteristic : CBCharacteristic!
    //var rssiCharacteristic : CBCharacteristic!
    
    // And somewhere to store the incoming data
    var data = NSMutableData()
    
    
    //Declare for save data
    var defaults: NSUserDefaults!
    
    var name: String!
    
    var uuid: NSString!
    
    var major: String!
    
    var minor: String!

    

    //Identity OutLet
    @IBOutlet weak var NameText: UILabel!
    
    @IBOutlet weak var RssiText: UILabel!
    
    @IBOutlet weak var StateText: UILabel!
    
    
    //Properties Outlet
    @IBOutlet weak var UUIDText: UILabel!
    
    @IBOutlet weak var MajorText: UILabel!
    
    @IBOutlet weak var MinorText: UILabel!
    
    @IBOutlet weak var SaveButton: UIButton!
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
        self.beaconServiceUUID = CBUUID(string: "955A1523-0FE2-F5AA-A094-84B8D4F3E8AD")
        self.beaconUUIDCharacteristicUUID = CBUUID(string: "955A1524-0FE2-F5AA-A094-84B8D4F3E8AD")
        self.majorMinorCharacteristicUUID = CBUUID(string: "955A1526-0FE2-F5AA-A094-84B8D4F3E8AD")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        print("\(#line) \(#function)")
        
        switch central.state{
            
        case .PoweredOff:
            
            let alert = UIAlertController(title: "Bluetooth is off", message: "please turn on", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            // The state must be CBCentralManagerStatePoweredOn...
        // ... so start scanning
        case .PoweredOn:
            
            scan()
            
        default:break
        }
        
        
    }
    
    /** Scan for peripherals - specifically for our service's 128bit CBUUID
     */
    func scan() {
        
        centralManager?.scanForPeripheralsWithServices(
            [beaconServiceUUID], options: [
                CBCentralManagerScanOptionAllowDuplicatesKey : NSNumber(bool: true)
            ]
        )
        
        print("Scanning started")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("Stopping scan")
        centralManager?.stopScan()
    }
    
    
    
    /** This callback comes whenever a peripheral that is advertising the TRANSFER_SERVICE_UUID is discovered.
     *  We check the RSSI, to make sure it's close enough that we're interested in it, and if it is,
     *  we start the connection process
     */
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        
        // Reject any where the value is above reasonable range
        // Reject if the signal strength is too low to be close enough (Close is around -22dB)
        
        //if  RSSI.integerValue < -15 && RSSI.integerValue > -35 {
        //print("Device not at correct range")
        //   return
        //}
        
        print("Discovered \(peripheral.name) at \(RSSI)")
        
        // Ok, it's in range - have we already seen it?
        
        if discoveredPeripheral != peripheral {
            // Save a local copy of the peripheral, so CoreBluetooth doesn't get rid of it
            discoveredPeripheral = peripheral
            
            // And connect
            print("Connecting to peripheral \(peripheral)")
            
            centralManager?.connectPeripheral(peripheral, options: nil)
            
            self.NameText.text = peripheral.name! as String
            
            self.RssiText.text = RSSI.stringValue
            
            
        }
    }
    

    
    /** If the connection fails for whatever reason, we need to deal with it.
     */
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("Failed to connect to \(peripheral). \(error!.localizedDescription)")
        
        //cleanup()
    }
    
    /** We've connected to the peripheral, now we need to discover the services and characteristics to find the 'transfer' characteristic.
     */
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("Peripheral Connected")
        
        // Stop scanning
        centralManager?.stopScan()
        print("Scanning stopped")
        
        // Clear the data that we may already have
        data.length = 0
        
        // Make sure we get the discovery callbacks
        peripheral.delegate = self
        
        // Search only for services that match our UUID
        peripheral.discoverServices([beaconServiceUUID])
        print("Search only for services that match our UUID")
        
        self.StateText.text = "Connect"
    }
    
    /** The Transfer Service was discovered
     */
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        if error != nil{
            print("Error discovering services: \(error!.localizedDescription)")
            cleanup()
        }
        
        else {
            for service: CBService in peripheral.services!{
                if service.UUID.isEqual(self.beaconServiceUUID){
                print("Service founded")
                self.discoveredPeripheral.discoverCharacteristics(nil, forService: service)
                }
            }
        }
    }
    
    /** The Transfer characteristic was discovered.
     *  Once this has been found, we want to subscribe to it, which lets the peripheral know we want the data it contains
     */
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        // Deal with errors (if any)
        if error != nil {
            print("Error discovering services: \(error!.localizedDescription)")
            cleanup()
            return
        }
        
        else {
            print( "didDiscoverCharacteristicsForService")
            if service.UUID.isEqual(self.beaconServiceUUID){
                for characteristic: CBCharacteristic in service.characteristics!{
                    if characteristic.UUID.isEqual(self.beaconUUIDCharacteristicUUID){
                        print("UUID Characteristic founded \(characteristic.UUID)")
                        self.beaconUUIDCharacteristic = characteristic
                        self.discoveredPeripheral.readValueForCharacteristic(characteristic)
                    }
                    
                    else if characteristic.UUID.isEqual(self.majorMinorCharacteristicUUID){
                        print("majorminor Characteristic founded \(characteristic.UUID)")
                        self.majorMinorCharacteristic = characteristic
                        self.discoveredPeripheral.readValueForCharacteristic(characteristic)
                    }
                }
            }
        }
        
    }
    
    func decodeUUID(data: NSData) -> NSString{
        print("decodeUUID")
        
        let value = UnsafePointer<UInt8>(data.bytes)
        
        let uuidString: NSMutableString = NSMutableString()
        
        for i in 0..<16 {
            uuidString.appendFormat("%02x", value[i])
            if i == 3 || i == 5 || i == 7 || i == 9{
                uuidString.appendString("-")
            }
        }
        return uuidString.copy() as! NSString
        
    }
    
    func decodeMajor(data: NSData) -> UInt16{
        print("decodeMajor")
        
        let value = UnsafePointer<UInt8>(data.bytes)
        
        return CFSwapInt16BigToHost(UInt16(value[0]))
    }
    
    func decodeMinor(data: NSData) -> UInt16{
        print("decodeMinor")
        
        let value = UnsafePointer<UInt8>(data.bytes)
        
        return CFSwapInt16BigToHost(UInt16(value[2]))
    }

    
    
    /** This callback lets us know more data has arrived via notification on the characteristic
     */
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        print("didUpdateValueForCharacteristic")
        
        if error != nil {
            print("Error discovering services: \(error!.localizedDescription)")
        }
        
        else {
            if characteristic.UUID.isEqual(self.beaconUUIDCharacteristicUUID){
                print("UUID characteristic Value:\(self.majorMinorCharacteristicUUID) and \(self.decodeUUID(characteristic.value!) as String)")
                
                self.UUIDText.text = self.decodeUUID(characteristic.value!) as String
            }
            else if characteristic.UUID.isEqual(self.majorMinorCharacteristicUUID){
                let major: NSString = String(format: "%hu", self.decodeMajor(characteristic.value!))
                let minor: NSString = String(format: "%hu", self.decodeMinor(characteristic.value!))
                print("Major characteristic Value: \(major)")
                print("Minor characteristic Value: \(minor)")
                self.MajorText.text = major as String
                self.MinorText.text = minor as String
                
            }
        }
        
    }
    
    func peripheral(peripheral: CBPeripheral, didWriteValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        if (error != nil) {
            print("Error in writing characteristic %@ \(characteristic.UUID)")
            let nsError = error! as NSError
            print(nsError.localizedDescription)
        }
        else{
            print("success characteristic written %@ \(characteristic.UUID)")
        }
    }
    
    
    
    
    /** Once the disconnection happens, we need to clean up our local copy of the peripheral
     */
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("Peripheral Disconnected")
        discoveredPeripheral = nil
        
        clearview()
         
        
        // We're disconnected, so start scanning again
        scan()
    }
    
    private func clearview(){
        self.UUIDText.text = "-"
        self.MajorText.text = "-"
        self.MinorText.text = "-"
        self.StateText.text = "Disconnect"
        
    }
    
    
    func cleanup() {
        // Don't do anything if we're not connected
        // self.discoveredPeripheral.isConnected is deprecated
        guard discoveredPeripheral?.state == .Connected else {
            return
        }
        
        // See if we are subscribed to a characteristic on the peripheral
        guard let services = discoveredPeripheral?.services else {
            cancelPeripheralConnection()
            return
        }
        
        for service in services {
            guard let characteristics = service.characteristics else {
                continue
            }
            
            for characteristic in characteristics {
                if characteristic.UUID.isEqual(beaconServiceUUID) && characteristic.isNotifying {
                    discoveredPeripheral?.setNotifyValue(false, forCharacteristic: characteristic)
                    // And we're done.
                    return
                }
            }
        }
    }
    
    func cancelPeripheralConnection() {
        // If we've got this far, we're connected, but we're not subscribed, so we just disconnect
        centralManager?.cancelPeripheralConnection(discoveredPeripheral!)
    }
    
    @IBAction func CancelPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        print("CancelPressed")
    }
    
    
    
    
    func saveData(){
        
        print("Save basics: NSUserDefaults")
        
        defaults = NSUserDefaults.standardUserDefaults()
        
        
        name = self.NameText.text!
        
        uuid = self.UUIDText.text!
        
        major = self.MajorText.text!
        
        minor = self.MinorText.text!
        
        
        
        defaults.setObject(name, forKey: "Name")
        print("Name: \(name)")
        
        defaults.setObject(uuid, forKey: "UUID")
        print("UUID: \(uuid)")
        
        defaults.setObject(major, forKey: "Major")
        print("Major: \(major)")
        
        defaults.setObject(minor, forKey: "Minor")
        print("Minor: \(minor)")
        

        
    }

   
    @IBAction func SavePressed(sender: AnyObject) {
        print("Add button pressed on Navigation bar")
        
        
        let uuid: NSString = self.UUIDText.text!
        
        if uuid.isEqualToString("-"){
            let alert = UIAlertController(title: "Error", message: "Can't add new Beacon, UUID is empty", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        
        
        else {
            saveData()
            
            let alert = UIAlertController(title: "Congrats!!!", message: "already save", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        print("Prepare for pass data")
        if (segue.identifier == "Ummagumma") {
    
            let svc = segue.destinationViewController as! SecondViewController;
            
            let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            if (defaults.objectForKey("Name") as? String) != nil {
                self.NameText.text = defaults.objectForKey("Name") as? String
                svc.toPass = self.NameText.text
                print("Passing name: \(self.NameText.text)")
            }
            
            if (defaults.objectForKey("UUID") as? String) != nil {
                self.UUIDText.text = defaults.objectForKey("UUID") as? String
                svc.toPass2 = self.UUIDText.text
                print("Passing name: \(self.UUIDText.text)")
            }
            
            if (defaults.objectForKey("Major") as? String) != nil {
                self.MajorText.text = defaults.objectForKey("Major") as? String
                svc.toPass3 = self.MajorText.text
                print("Passing name: \(self.MajorText.text)")
            }
            
            if (defaults.objectForKey("Minor") as? String) != nil {
                self.MinorText.text = defaults.objectForKey("Minor") as? String
                svc.toPass4 = self.MinorText.text
                print("Passing name: \(self.MinorText.text)")
            }
            
            if (defaults.objectForKey("Name") as? String) == nil {
                self.NameText.text = "-"
                svc.toPass = self.NameText.text
                print("Passing name: \(self.NameText.text)")
            }
            
            if (defaults.objectForKey("UUID") as? String) == nil {
                self.UUIDText.text = "-"
                svc.toPass2 = self.UUIDText.text
                print("Passing name: \(self.UUIDText.text)")
            }
            
            if (defaults.objectForKey("Major") as? String) == nil {
                self.MajorText.text = "-"
                svc.toPass3 = self.MajorText.text
                print("Passing name: \(self.MajorText.text)")
            }
            
            if (defaults.objectForKey("Minor") as? String) == nil {
                self.MinorText.text = "-"
                svc.toPass4 = self.MinorText.text
                print("Passing name: \(self.MinorText.text)")
            }
            
            
            
            
        }
    }

}
