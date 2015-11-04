//
//  PassengerInformationVC.swift
//  tiket-com-swift-2
//
//  Created by Achmad Fatoni on 10/31/15.
//  Copyright © 2015 Achmad Fatoni. All rights reserved.
//

import UIKit
import SwiftForms
import SwiftSpinner
import SwiftyJSON

class PassengerInformationVC: FormViewController {

    let tiketApi = TiketAPI()
    
    var countries = Countries()
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var flightId = ""
    
    var flightData:JSON = []
    
    var numberOfpassengers = NumberOfPassengers()
    
    var parentArray = [Int]()
    
    var errorMsg = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "submit:")
        
        //parent array
        for var i = 1; i <= numberOfpassengers.adult; i++ {
            parentArray.append(i)
        }
        
        print("------ Flight Data ------")
        print(self.flightData)
        print("------ END Flight Data ------")
        
        
        self.loadFormContent()
        
        print(flightId)
        print(numberOfpassengers.adult)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    func submit(_: UIBarButtonItem!) {
        
        self.view.endEditing(true)
        
        let validateForm        = self.form.validateForm()
        
        if validateForm == nil {
            var formValues = self.form.formValues()
            
            print("---------- Form Values ----------")
            print(formValues);
            
            var params = [String:AnyObject]()
            params["flight_id"] = self.flightId
            
            for (key, value) in formValues {
                params[key as! String] = value
                print("key: \(key) value: \(value)")
            }
            
            print("---------- Params ----------")
            print(params)
            
            

            SwiftSpinner.show("Adding order")
            
            self.tiketApi.addOrder(params, completion: { (response) -> Void in
                SwiftSpinner.hide()
                print(response)
                
                if let errorMsg = response["diagnostic"]["error_msgs"].string {
                    print("---------- Error msg ----------")
                    self.errorMsg = errorMsg.stringByReplacingOccurrencesOfString("you are using insecure protocol,", withString: "")
                    
                    
                    print(self.errorMsg)
                    
                    let alertController = UIAlertController(title: "Error", message: self.errorMsg, preferredStyle: .Alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                }else{
                    
                    self.performSegueWithIdentifier("goToCartVC", sender: nil)
                }
                
            })


            
        }else{
            let alertController = UIAlertController(title: "Validation Failed", message: "\(validateForm.title) required", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    private func loadForm(){
        let form = FormDescriptor()
        
        form.title  = "Informasi Penumpang"
        
        self.form = form

    }
    
    
    private func loadFormContent(){
        
        
        let form = FormDescriptor()
        
        form.title = "Passengers Information"
        
        let section = FormSectionDescriptor()
        
        section.headerTitle = "Contact Person"
        
        //contact title
        var row: FormRowDescriptor! = FormRowDescriptor(tag: "conSalutation", rowType: .Picker, title: "Title")
        row.configuration[FormRowDescriptor.Configuration.Options] = ["Mr", "Ms", "Mrs"]
        row.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = false
        row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
            return (value as! String)
            } as TitleFormatterClosure
        
        section.addRow(row)
        
        //contact first name
        row = FormRowDescriptor(tag: "conFirstName", rowType: .Name, title: "First Name")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]
        
        section.addRow(row)
        
        //contact last name
        row = FormRowDescriptor(tag: "conLastName", rowType: .Name, title: "Last Name")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]

        section.addRow(row)

        //contact phone
        row = FormRowDescriptor(tag: "conPhone", rowType: .Phone, title: "Phone")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]

        section.addRow(row)
        
        //email address
        row = FormRowDescriptor(tag: "conEmailAddress", rowType: .Email, title: "Email Address")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]

        section.addRow(row)

        form.sections.append(section)
        
        
        
        for var i = 1; i <= numberOfpassengers.adult; i++
        {
            var section = FormSectionDescriptor()

            section.headerTitle = "Adult \(i)"
            
            //adult title
            var row: FormRowDescriptor! = FormRowDescriptor(tag: "titlea\(i)", rowType: .Picker, title: "Title")
            row.configuration[FormRowDescriptor.Configuration.Options] = ["Mr", "Ms", "Mrs"]
            row.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = false
            row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
                return (value as! String)
                } as TitleFormatterClosure
            
            section.addRow(row)
            
            
            //adult first name
             row = FormRowDescriptor(tag: "firstnamea\(i)", rowType: .Name, title: "First Name")
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]

            section.addRow(row)

            //adultlast name
            row = FormRowDescriptor(tag: "lastnamea\(i)", rowType: .Name, title: "Last Name")
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]

            section.addRow(row)

            //id = ktp/sim/passport
            row = FormRowDescriptor(tag: "ida\(i)", rowType: .Text, title: "No ID")
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]

            section.addRow(row)
            
            
            //bithdate
            if let birthdate = self.flightData["required"]["birthdatea\(i)"].dictionary{
                row = FormRowDescriptor(tag: "birthdatea\(i)", rowType: .Date, title: "Birthdate")
                section.addRow(row)
            }
            
            //passport no
            if let passportNo = self.flightData["required"]["passportnoa\(i)"].dictionary {
                row = FormRowDescriptor(tag: "passportnoa\(i))", rowType: .Text, title: "Passport No")
                row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]
            
                section.addRow(row)
                
            }
            
            //passport expired date
            if let passportExpired = self.flightData["required"]["passportExpiryDatea\(i)"].dictionary {
                row = FormRowDescriptor(tag: "passportExpiryDatea\(i))", rowType: .Date, title: "Passport Expired")
                row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]
                
                section.addRow(row)
                
            }
            
            //passportissueddatea
            if let passportissueddatea = self.flightData["required"]["passportissueddatea\(i)"].dictionary {
                row = FormRowDescriptor(tag: "passportissueddatea\(i))", rowType: .Date, title: "Passport Issued")
                row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]
                
                section.addRow(row)
                
            }
            
            //passportissuinga1
            if let passportNationality = self.flightData["required"]["passportissuinga\(i)"].dictionary {
                
                //adult title
                row = FormRowDescriptor(tag: "passportissuinga\(i)", rowType: .Picker, title: "Passport Issued Country")
                row.configuration[FormRowDescriptor.Configuration.Options] = self.countries.countryIdArray
                row.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = false
                row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
                    return self.countries.countryNameArray[value as! String]
                    } as TitleFormatterClosure
                
                section.addRow(row)
            }

            
            //passport nationality
            if let passportNationality = self.flightData["required"]["passportnationalitya\(i)"].dictionary {

                //adult title
                row = FormRowDescriptor(tag: "passportnationalitya\(i)", rowType: .Picker, title: "Passport Nationality")
                row.configuration[FormRowDescriptor.Configuration.Options] = self.countries.countryIdArray
                row.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = false
                row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
                    return self.countries.countryNameArray[value as! String]
                    } as TitleFormatterClosure
                
                section.addRow(row)
            }
            
            //dcheckinbaggagea
            if let dcheckinbaggagea = self.flightData["required"]["dcheckinbaggagea1\(i)"].dictionary {
                
                var idArray = [String]()
                var nameDict = [String:String]()
                
                for id in dcheckinbaggagea["resource"]!.array! {
                    idArray.append(id["id"].string!)
                    nameDict[id["id"].string!] = id["name"].string!
                }
                
                
                //adult title
                row = FormRowDescriptor(tag: "dcheckinbaggagea11\(i)", rowType: .Picker, title: "Departure Baggage")
                row.configuration[FormRowDescriptor.Configuration.Options] = idArray
                row.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = false
                row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
                    return nameDict[value as! String]
                    } as TitleFormatterClosure
                
                section.addRow(row)
            }


            form.sections.append(section);
        }
        
        for var i = 1; i <= numberOfpassengers.child; i++
        {
            var section = FormSectionDescriptor()
            
            section.headerTitle = "Child \(i)"
            
            //child title
            var row: FormRowDescriptor! = FormRowDescriptor(tag: "titlec\(i)", rowType: .Picker, title: "Title")
            row.configuration[FormRowDescriptor.Configuration.Options] = ["Mr", "Ms", "Mrs"]
            row.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = false
            row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
                return (value as! String)
                } as TitleFormatterClosure
            
            section.addRow(row)
            
            //child first name
            row = FormRowDescriptor(tag: "firstnamec\(i)", rowType: .Name, title: "First Name")
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]
            
            section.addRow(row)
            
            //child last name
            row = FormRowDescriptor(tag: "lastnamec\(i)", rowType: .Name, title: "Last Name")
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]
            
            section.addRow(row)
            
            //bithdate
            row = FormRowDescriptor(tag: "birthdatec\(i)", rowType: .Date, title: "Birthdate")
            
            section.addRow(row)
            
            form.sections.append(section);
        }
        
        for var i = 1; i <= numberOfpassengers.infant; i++
        {
            var section = FormSectionDescriptor()
            
            section.headerTitle = "Infant \(i)"
            
            //infant title
            var row: FormRowDescriptor! = FormRowDescriptor(tag: "titlei\(i)", rowType: .Picker, title: "Title")
            row.configuration[FormRowDescriptor.Configuration.Options] = ["Mr", "Ms", "Mrs"]
            row.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = false
            row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
                return (value as! String)
                } as TitleFormatterClosure
            
            section.addRow(row)
            
            //parent
            row = FormRowDescriptor(tag: "parenti\(i)", rowType: .Picker, title: "Parent")
            row.configuration[FormRowDescriptor.Configuration.Options] = self.parentArray
            row.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = false
            row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
                return (String(value))
                } as TitleFormatterClosure
            
            section.addRow(row)
            
            //contact first name
            row = FormRowDescriptor(tag: "firstnamei\(i)", rowType: .Name, title: "First Name")
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]
            
            section.addRow(row)
            
            //contact last name
            row = FormRowDescriptor(tag: "lastnamei\(i)", rowType: .Name, title: "Last Name")
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]
            
            section.addRow(row)
            
            //birthdate
            row = FormRowDescriptor(tag: "birthdatei\(i)", rowType: .Date, title: "Birthdate")
            
            section.addRow(row)
            
            form.sections.append(section);
        }

        
        
        self.form = form
    
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
