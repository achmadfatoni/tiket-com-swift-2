//
//  FlightsVC.swift
//  tiket-com-swift-2
//
//  Created by Achmad Fatoni on 10/30/15.
//  Copyright © 2015 Achmad Fatoni. All rights reserved.
//

import UIKit
import SwiftyJSON

class FlightsVC: UITableViewController {

    var flights: JSON = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(self.flights["go_det"]["dep_airport"]["city_name"].string!) - \(self.flights["go_det"]["arr_airport"]["city_name"].string!)"

        self.tableView.rowHeight = 80
        self.tableView.reloadData()

        //print(self.flights)

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
        return self.flights["departures"]["result"].count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FlightCell

        // Configure the cell...
        var flightsArray = self.flights["departures"]["result"].array!
        
        let indexPath =  flightsArray[indexPath.row]
        cell.airlaneName.text = indexPath["airlines_name"].string!
        cell.priceValue.text  = "IDR " + indexPath["price_value"].string!
        cell.time.text        = indexPath["simple_departure_time"].string! + " - " + indexPath["simple_arrival_time"].string!
        return cell
    }



}
