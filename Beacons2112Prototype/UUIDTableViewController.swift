//
//  UUIDTableViewController.swift
//  Beacons2112Prototype
//
//  Created by incloud company on 6/21/2559 BE.
//  Copyright © 2559 incloud. All rights reserved.
//

import UIKit

class UUIDTableViewController: UITableViewController {
    
    var chosenUUID: NSUUID!
    var getBeaconsUUIDS: NSArray!
    
    func getBeaconsUUIDS(uuids: NSArray) -> NSArray{
        var uuidss = uuids
        if uuidss.count == 0{
            
            uuidss = [NSUUID.init(UUIDString: "01122334-4556-6778-899A-ABBCCDDEEFF0")!,
                      NSUUID.init(UUIDString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")!,
                      NSUUID.init(UUIDString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!,
                      NSUUID.init(UUIDString: "74278BDA-B644-4520-8F0C-720EAF059935")!]
        }
        return uuidss
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return getBeaconsUUIDS.count
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        
        if getBeaconsUUIDS.objectAtIndex(indexPath.row).isEqual(self.chosenUUID){
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        cell.textLabel?.font = UIFont.systemFontSize(12.0)
        cell.textLabel?.text =

        return cell
    }*/
    

    /*
     
     
     if ([[[Utility getBeaconsUUIDS] objectAtIndex:indexPath.row] isEqual:self.chosenUUID]) {
     cell.accessoryType = UITableViewCellAccessoryCheckmark;
     }
     cell.textLabel.font = [UIFont systemFontOfSize:12.0];
     cell.textLabel.text = [[[Utility getBeaconsUUIDS] objectAtIndex:indexPath.row] UUIDString];
     
     
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
