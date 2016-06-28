//
//  BeaconDB.swift
//  Beacons2112Prototype
//
//  Created by incloud company on 6/22/2559 BE.
//  Copyright © 2559 incloud. All rights reserved.
//

import UIKit
import CoreData

class BeaconDB: NSObject {
    
    /*
    var addStatus: BeaconAddStatus!
    var appDelegate:AppDelegate
    var context: NSManagedObjectContext!
    
    
    
    override init(){
        
        self.appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.context = appDelegate.managedObjectContext
        
    }
    
    enum BeaconAddStatus{
        case DUPLICATE_IN_AD
        case ADDED_SUCCESSFULL
        case ERROR_IN_ADD
    }
    
    
    func addNewBeacon(beacon: BeaconData) -> BeaconAddStatus{
        print("ADDNewBeacon")
        print("uuid: %@ \(beacon.uuid)")
        
        //let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //let context: NSManagedObjectContext = appDelegate.managedObjectContext
        
        let entityDesc: NSEntityDescription = NSEntityDescription.entityForName("Beacon", inManagedObjectContext: context)!
        let request: NSFetchRequest = NSFetchRequest()
        let predSearch: NSPredicate = NSPredicate(format: "(uuid = %@) AND (major = %@) AND (minor = %@) \(beacon.uuid), \(beacon.major), \(beacon.minor)")
        
        request.entity = entityDesc
        request.predicate = predSearch
        
        
        do {
            let existingBeacon = try context.executeFetchRequest(request) as! [Beacons]
            // success ...
            print("Cant add beacon. it is already present")
            addStatus = BeaconAddStatus.DUPLICATE_IN_AD
            
            if existingBeacon == [0]{
                print("Beacon is added in Phone")
                addStatus = BeaconAddStatus.ADDED_SUCCESSFULL
            }
            
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        
        
    
        
        
        return addStatus
        
    }
    
    func add(beacon: BeaconData) -> Void {
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        
        let newBeacon: Beacons = NSEntityDescription.insertNewObjectForEntityForName("Beacon", inManagedObjectContext: context) as! Beacons
        
        newBeacon.setValue(beacon.name, forKey: "name")
        newBeacon.setValue(beacon.uuid, forKey: "uuid")
        newBeacon.setValue(beacon.major, forKey: "major")
        newBeacon.setValue(beacon.minor, forKey: "minor")
    }*/

}


