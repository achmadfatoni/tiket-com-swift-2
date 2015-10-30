//
//  SearchFlightViewController.swift
//  tiket-com-swift-2
//
//  Created by Achmad Fatoni on 10/16/15.
//  Copyright © 2015 Achmad Fatoni. All rights reserved.
//

import UIKit
import SwiftForms
import SwiftyJSON

class SearchFlightViewController: FormViewController {
    
    let tiketApi = TiketAPI()
    
    //var airportCodeArray = [String]()
    var airportDictionary = [String:String]()
    
    var airportCodeArray = ["ARD", "AMQ", "ABU", "BJW", "BPN", "BTJ", "BDO", "BDJ", "DQJ", "BTH", "BUW", "BKS", "BEJ", "MTW", "BIK", "BMU", "BWX", "WUB", "UOL", "DPS", "ENE", "FKQ", "GLX", "GTO", "GNS", "CGK", "HLP", "DJB", "DJJ", "KNG", "KDI", "KTG", "KBU", "KOE", "LBJ", "LAH", "TKG", "LSW", "LOP", "LUW", "MLG", "MLN", "MJU", "MDC", "MKW", "MOF", "KNO", "MLK", "MNA", "MKQ", "MEQ", "OTI", "NBX", "NTX", "NNX", "PDG", "PKY", "PLM", "PLW", "PGK", "PKN", "PKU", "PUM", "PNK", "PSJ", "PSU", "RTI", "RTG", "SRI", "SMQ", "SXK", "YKR", "SRG", "RRZ", "DTB", "SNX", "SQG", "SOC", "SOQ", "SWQ", "SUB", "NAH", "TMC", "TJQ", "TNJ", "TJS", "TJG", "TRK", "TTE", "TIM", "KAZ", "TLI", "LUV", "UPG", "WGP", "WNI", "WMX", "WGI", "JOG", "ADL", "ASP", "AVV", "BNK", "BNE", "CNS", "CBR", "CFS", "DRW", "OOL", "HTI", "HIS", "HBA", "LST", "MKY", "MEL", "VIZ", "NTL", "PER", "MCY", "SYD", "TSV", "AYQ", "PPP", "CGP", "DEL", "DAC", "BWN", "PNH", "REP", "PEK", "CTU", "CKG", "CAN", "KWL", "HAK", "HGH", "KMG", "NNG", "NGB", "TAO", "PVG", "SWA", "SHE", "SZX", "TSN", "WUH", "XIY", "CMB", "NAN", "HKG", "AMD", "BLR", "MAA", "HYD", "COK", "CCU", "BOM", "TRV", "TRZ", "FUK", "KOJ", "KMJ", "MYJ", "NGO", "OIT", "OKA", "KIX", "CTS", "TAK", "HND", "NRT", "VTE", "MFM", "AOR", "BTU", "JHB", "KBR", "BKI", "KUL", "TGG", "KCH", "LGK", "MKZ", "MYY", "PEN", "SDK", "SBW", "SZB", "IPH", "TWU", "MDL", "RGN", "KTM", "AKL", "CHC", "DUD", "ZQN", "WLG", "BCD", "CEB", "CRK", "DVO", "ILO", "MNL", "PPS", "TAC", "JED", "SIN", "PUS", "ICN", "TPE", "BKK", "DMK", "CNX", "CEI", "HDY", "KBV", "KOP", "NST", "NAW", "HKT", "URT", "TST", "UBP", "UTH", "DIL", "ABU", "LGW", "HNL", "BMV", "DAD", "VDH", "HPH", "SGN", "HUI", "CXR", "HAN", "PQC", "UIH", "THD", "TBB", "VII"]


    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .Plain, target: self, action: "submit:")
        
        
        self.tiketApi.getTiketToken({(token) in
            print("token : " + token)
            
            self.tiketApi.getAirport(token, completion: { (airports) -> Void in
                print("---------- Airport ----------")
                //print(airports)
                for airport in airports {
                    //print("---------- Airport Code ----------")
                    let airportCode = airport["airport_code"].string!
                    //print(airportCode)
                    //self.airportCodeArray.append(airportCode)
                    self.airportDictionary[airportCode] = airport["location_name"].string!
                }
                
            })

        })
        
        
    }
    
    /// MARK: Actions
    
    func submit(_: UIBarButtonItem!) {
        
        let validateForm        = self.form.validateForm()
        
        if validateForm == nil {
            let formValues = self.form.formValues()
            
            let departureAirportCode    = "\(formValues["departureAirportCode"]!)"
            let arrivalAirportCode      = "\(formValues["arrivalAirportCode"]!)"
            
            let adult   = formValues["adultPassenger"] as! String
            let child   = formValues["childPassenger"] as! String
            let infant  = formValues["infantPassenger"] as! String
            
            //prepare param departure airport code
            let d       = departureAirportCode.stringByReplacingOccurrencesOfString("(", withString: "").stringByReplacingOccurrencesOfString(")", withString: "").stringByReplacingOccurrencesOfString("\n", withString: "").stringByReplacingOccurrencesOfString(" ", withString: "")
            
            
            let a = arrivalAirportCode.stringByReplacingOccurrencesOfString("(", withString: "").stringByReplacingOccurrencesOfString(")", withString: "").stringByReplacingOccurrencesOfString("\n", withString: "").stringByReplacingOccurrencesOfString(" ", withString: "")
            
            
            
            let date = NSDateFormatter()
            date.dateFormat = "yyyy-MM-dd"
            let departureDate = date.stringFromDate(self.valueForTag("departDate") as! NSDate)
            
            //date format
            //YYYY-MM-DD
            
            let params = [
                "d"			:	d,
                "a"			:	a,
                "date"		:	departureDate,
                //"ret_date"	:	$ret_date,
                "adult"		:	adult,
                "child"		:	child,
                "infant"	:	infant
            ]
            print(params)
            
//            self.tiketApi.searchFlight(params, completion: { (airports) -> Void in
//                print(params)
//            })
            //performSegueWithIdentifier("goToFlight", sender: nil)
        
        }else{
            let alertController = UIAlertController(title: "Validation Failed", message: "\(validateForm.title) required", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
        
        
    }
    

    
    /// MARK: Private interface
    
    private func loadForm() {
        
        let form = FormDescriptor()
        
        form.title = "Search Flight"
        
        let section1 = FormSectionDescriptor()
        //departure airport
        var row: FormRowDescriptor! = FormRowDescriptor(tag: "departureAirportCode", rowType: .MultipleSelector, title: "Departure")
        row.configuration[FormRowDescriptor.Configuration.Options] = self.airportCodeArray
        row.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = false
        row.configuration[FormRowDescriptor.Configuration.Required] = true
        row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
            return self.airportDictionary[value as! String]
        } as TitleFormatterClosure
        
        section1.addRow(row)
        
        // arrival airport
        row = FormRowDescriptor(tag: "arrivalAirportCode", rowType: .MultipleSelector, title: "Arrival")
        row.configuration[FormRowDescriptor.Configuration.Options] = self.airportCodeArray
        row.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = false
        row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
            return self.airportDictionary[value as! String]
        } as TitleFormatterClosure
        
        section1.addRow(row)
        
        //depart date
        row = FormRowDescriptor(tag: "departDate", rowType: .Date, title: "Depart Date")
        section1.addRow(row)
        
        let section2 = FormSectionDescriptor()
        section2.headerTitle = "Number of Passengers"
        //adult
        row = FormRowDescriptor(tag: "adultPassenger", rowType: .Number, title: "Adult")
        row.value = "1"
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section2.addRow(row)
        //child
        row = FormRowDescriptor(tag: "childPassenger", rowType: .Number, title: "Child")
        row.value = "0"
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section2.addRow(row)
        
        row = FormRowDescriptor(tag: "infantPassenger", rowType: .Number, title: "Infant")
        row.value = "0"
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section2.addRow(row)
        
        form.sections = [section1, section2]
        
        self.form = form
    }
}
