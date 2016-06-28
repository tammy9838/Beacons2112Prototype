//
//  SecondViewController.swift
//  Beacons2112Prototype
//
//  Created by incloud company on 6/16/2559 BE.
//  Copyright © 2559 incloud. All rights reserved.
//
import CoreBluetooth
import UIKit

class SecondViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var centralManager: CBCentralManager!
    
    var toPass:String!
    var toPass2:String!
    var toPass3:String!
    var toPass4:String!
    
  
    @IBOutlet weak var NameTextt: UILabel!
    
    @IBOutlet weak var UUIDTextt: UILabel!
    
    @IBOutlet weak var MajorTextt: UILabel!
    
    @IBOutlet weak var MinorTextt: UILabel!
    
    
    @IBOutlet weak var ClearButton: UIBarButtonItem!
    
    
    @IBAction func ClearPressed(sender: AnyObject) {
        print("Clear button pressed")
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("Name")
        defaults.removeObjectForKey("UUID")
        defaults.removeObjectForKey("Major")
        defaults.removeObjectForKey("Minor")
        defaults.synchronize()
        
        clearview()
    }
    

  
    @IBAction func LoadPressed(sender: AnyObject) {
        print("load button pressed")
        
        self.NameTextt.text = toPass
        self.UUIDTextt.text = toPass2
        self.MajorTextt.text = toPass3
        self.MinorTextt.text = toPass4
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        print("UpdateState")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("Stopping scan")
        centralManager?.stopScan()
    }
    
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        centralManager?.stopScan()
        print("Scanning stopped")
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func clearview(){
        self.UUIDTextt.text = "-"
        self.MajorTextt.text = "-"
        self.MinorTextt.text = "-"
        self.NameTextt.text = "-"
        
    }
    



}

