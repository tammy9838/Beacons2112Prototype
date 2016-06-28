//
//  FirstViewController.swift
//  Beacons2112Prototype
//
//  Created by incloud company on 6/16/2559 BE.
//  Copyright © 2559 incloud. All rights reserved.
//

import UIKit
import CoreBluetooth

class FirstViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {

    private var centralManager: CBCentralManager?
    private var discoveredPeripheral: CBPeripheral?
    
    
    @IBOutlet weak var ScanButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start up the CBCentralManager
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
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
            
        default:break
        }
    }
    


}

