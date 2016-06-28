//
//  TabBarController.swift
//  Beacons2112Prototype
//
//  Created by incloud company on 6/22/2559 BE.
//  Copyright © 2559 incloud. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        func uicolorFromHex(rgbValue:UInt32)->UIColor{
            let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
            let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
            let blue = CGFloat(rgbValue & 0xFF)/256.0
            
            return UIColor(red:red, green:green, blue:blue, alpha:1.0)
        }
        
        var TabBarApprarance = UITabBar.appearance()
        
        
        // Sets the default color of the icon of the selected UITabBarItem and Title
        TabBarApprarance.tintColor = uicolorFromHex(0xFE9A2A)
        
        // Sets the default color of the background of the UITabBar
        //UITabBar.appearance().barTintColor = uicolorFromHex.()
        
        /* Sets the background color of the selected UITabBarItem (using and plain colored UIImage with the width = 1/5 of the tabBar (if you have 5 items) and the height of the tabBar)
         //UITabBar.appearance().selectionIndicatorImage = UIImage().makeImageWithColorAndSize(UIColor.blueColor(), size: CGSizeMake(tabBar.frame.width/5, tabBar.frame.height))
         
         // Uses the original colors for your images, so they aren't not rendered as grey automatically.
         //for item in self.tabBar.items as! [UITabBarItem] {
         // if let image = item.image {
         //item.image = image.imageWithRenderingMode(.AlwaysOriginal)
         //}
         // }
         }*/
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
