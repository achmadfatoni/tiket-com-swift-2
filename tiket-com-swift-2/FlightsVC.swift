//
//  FlightsVC.swift
//  tiket-com-swift-2
//
//  Created by Achmad Fatoni on 10/30/15.
//  Copyright © 2015 Achmad Fatoni. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftForms

class FlightsVC: UITableViewController {

    let api = TiketAPI()
    var flights: JSON = []
    var flightData: JSON = []
    var flightId:String = ""
    var numberOfPassengers  = NumberOfPassengers()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(self.flights["go_det"]["dep_airport"]["city_name"].string!) - \(self.flights["go_det"]["arr_airport"]["city_name"].string!)"

        self.tableView.rowHeight = 80
        self.tableView.reloadData()

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
        
        cell.flightId         = indexPath["flight_id"].string!
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! FlightCell
        
        self.flightId = cell.flightId
        
        self.api.flightData(self.flightId) { (flightData) -> Void in
            
            self.flightData = flightData
            
            self.performSegueWithIdentifier("goToPassengerInformation", sender: nil)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToPassengerInformation" {
            navigationItem.title = " "
            
            let passengerInformationVC                  = segue.destinationViewController as! PassengerInformationVC
            
            passengerInformationVC.numberOfpassengers   = self.numberOfPassengers
            passengerInformationVC.flightId             = self.flightId
            passengerInformationVC.flightData           = self.flightData
            
        }
    }



}
