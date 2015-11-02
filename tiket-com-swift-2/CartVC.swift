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
    
    let tiketApi = TiketAPI()
    var orders: JSON = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        SwiftSpinner.show("Loading")
        self.tiketApi.cart { (orders) -> Void in
            
            

            print(orders)
            self.orders = orders
            
            print("---------- My Order ----------")
            print(self.orders["myorder"]["data"].array!)
            
            print("---------- Amount Order ----------")
            print(self.orders["myorder"]["data"].count)
            
            self.tableView.reloadData()
            SwiftSpinner.hide()
        }
        

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
        
        if self.orders["myorder"]["data"].count == 0 {
            return 1
        }else {
            return self.orders["myorder"]["data"].count
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        if self.orders["myorder"]["data"].count == 0 {
            cell.textLabel?.text    = "No Order Found"
        }else{
            var orderArray = self.orders["myorder"]["data"].array!
            
            let indexPath           =  orderArray[indexPath.row]
            cell.textLabel?.text    = indexPath["order_name_detail"].string!
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
        if self.orders["myorder"]["data"].count == 0 {
            
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
                    
                    self.tableView.reloadData()
                    SwiftSpinner.hide()
                }
                
                SwiftSpinner.hide()
            })
        }
        
        
    }
    

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
