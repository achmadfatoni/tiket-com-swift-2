//
//  CartVC.swift
//  tiket-com-swift-2
//
//  Created by Achmad Fatoni on 11/2/15.
//  Copyright © 2015 Achmad Fatoni. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftSpinner

class CartVC: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var checkoutButton: UIBarButtonItem!
    
    let tiketApi = TiketAPI()
    var orders: JSON = []
    var errorMsg = ""
    var errorCheckoutMsg = ""
    var orderId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        SwiftSpinner.show("Loading")
        self.tiketApi.cart { (orders) -> Void in
            
            
            if let errorMsg = orders["diagnostic"]["error_msgs"].string {
                print("---------- Error msg ----------")
                self.errorMsg = orders["diagnostic"]["error_msgs"].string!
                print(self.errorMsg)
                
                //hide checkout button
                self.navigationItem.rightBarButtonItem = nil
                
            }else{
                print(orders)
                self.orders = orders
                
                //set orderId
                self.orderId = self.orders["myorder"]["order_id"].string!
                
                print("---------- My Order ----------")
                print(self.orders["myorder"]["data"].array!)
                
                print("---------- Amount Order ----------")
                print(self.orders["myorder"]["data"].count)
                
                if self.orders["myorder"]["data"].count == 0 {
                    //hide checkout button
                    self.navigationItem.rightBarButtonItem = nil
                }
            }
            
            self.tableView.reloadData()
            SwiftSpinner.hide()
        }
        
    }

    @IBAction func checkout(sender: AnyObject) {
        print("Order Id : \(self.orderId)")
        
        
        SwiftSpinner.show("Loading...")
        self.tiketApi.checkoutRequest(self.orderId) { (response) -> Void in
            if let errorMsg = response["diagnostic"]["error_msgs"].string {
                print("---------- Error msg ----------")
                self.errorCheckoutMsg = errorMsg.stringByReplacingOccurrencesOfString("you are using insecure protocol,", withString: "")
                
                
                print(self.errorCheckoutMsg)
                
                let alertController = UIAlertController(title: "Error", message: self.errorCheckoutMsg + ", Please delete order that already Expired", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
                
            }else{
                
                self.performSegueWithIdentifier("goToCheckout", sender: nil)
            }
            
            SwiftSpinner.hide()
        }
        
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
        if (self.orders["myorder"]["data"].count == 0) || (self.errorMsg != "") {
            return 1
        }else {
            return self.orders["myorder"]["data"].count
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        if (self.orders["myorder"]["data"].count == 0) || (self.errorMsg != "") {
            cell.textLabel?.text    = "No Order Found"
            cell.detailTextLabel?.text = ""
            
        }else{
            var orderArray = self.orders["myorder"]["data"].array!
            var status     = "Expired"
            
            
            let indexPath           =  orderArray[indexPath.row]
            
            if indexPath["order_detail_status"].string! == "active" {
                status = "Active"
            }
            
            cell.textLabel?.text    = indexPath["order_name_detail"].string!
            
            cell.detailTextLabel?.text    = status
        }
       

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if (self.orders["myorder"]["data"].count == 0) || (self.errorMsg != "") {
            
            return UITableViewCellEditingStyle.None
    
        }
        
        return UITableViewCellEditingStyle.Delete;
    }

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            var orderArray = self.orders["myorder"]["data"].array!
            
            let data          =  orderArray[indexPath.row]
            
            SwiftSpinner.show("Delete Order")
            self.tiketApi.deleteOrder(data["order_detail_id"].string!, completion: { (response) -> Void in
                print(response)
                
                self.tiketApi.cart { (orders) -> Void in
                    
                    
                    
                    print(orders)
                    self.orders = orders
                    
                    print("---------- My Order ----------")
                    print(self.orders["myorder"]["data"].array!)
                    
                    print("---------- Amount Order ----------")
                    print(self.orders["myorder"]["data"].count)
                    
                    
                    if self.orders["myorder"]["data"].count == 0 {
                        //hide checkout button
                        self.navigationItem.rightBarButtonItem = nil
                    }
                    
                    self.tableView.reloadData()
                    SwiftSpinner.hide()
                }
                
                SwiftSpinner.hide()
            })
        }
        
        
    }
    

}
