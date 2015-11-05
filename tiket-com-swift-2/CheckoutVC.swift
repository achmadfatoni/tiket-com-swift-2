//
//  CheckoutVC.swift
//  tiket-com-swift-2
//
//  Created by Achmad Fatoni on 11/4/15.
//  Copyright © 2015 Achmad Fatoni. All rights reserved.
//

import UIKit
import SwiftForms
import SwiftSpinner


class CheckoutVC: FormViewController {
    
    let tikeApi = TiketAPI()
    var errorCheckoutMsg = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func loadForm(){
        let form = FormDescriptor()
        
        form.title  = "Checkout"
        
        let section = FormSectionDescriptor()
        
        section.headerTitle = "Register"
        
        //contact title
        var row: FormRowDescriptor! = FormRowDescriptor(tag: "salutation", rowType: .Picker, title: "Title")
        row.configuration[FormRowDescriptor.Configuration.Options] = ["Mr", "Ms", "Mrs"]
        row.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = false
        row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
            return (value as! String)
            } as TitleFormatterClosure
        
        section.addRow(row)
        
        //contact first name
        row = FormRowDescriptor(tag: "firstName", rowType: .Name, title: "First Name")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]
        
        section.addRow(row)
        
        //contact last name
        row = FormRowDescriptor(tag: "lastName", rowType: .Name, title: "Last Name")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]
        
        section.addRow(row)
        
        //contact phone
        row = FormRowDescriptor(tag: "phone", rowType: .Phone, title: "Phone")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]
        
        section.addRow(row)
        
        //email address
        row = FormRowDescriptor(tag: "emailAddress", rowType: .Email, title: "Email Address")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]
        
        section.addRow(row)
        row = FormRowDescriptor(tag: "register", rowType: .Button, title: "Checkout")
        row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
            
            if self.valueForTag("salutation") == nil {
                let alertController = UIAlertController(title: "Error", message: "Title Required", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }else if self.valueForTag("firstName") == nil {
                let alertController = UIAlertController(title: "Error", message: "First Name Required", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }else if self.valueForTag("lastName") == nil {
                let alertController = UIAlertController(title: "Error", message: "Last Name Required", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }else if self.valueForTag("phone") == nil {
                let alertController = UIAlertController(title: "Error", message: "Phone Required", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }else if self.valueForTag("emailAddress") == nil {
                let alertController = UIAlertController(title: "Error", message: "Email Address Required", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                var params = [
                    "salutation"    : self.valueForTag("salutation") as! String,
                    "firstName"     : self.valueForTag("firstName") as! String,
                    "lastName"      : self.valueForTag("lastName") as! String,
                    "phone"         : self.valueForTag("phone") as! String,
                    "emailAddress"  : self.valueForTag("emailAddress") as! String
                ]
                
                self.register(params)
            }
        } as DidSelectClosure
        
        section.addRow(row)
        
        form.sections.append(section)
        
        //------ END REGISTER
        
        
        let OR = FormSectionDescriptor()
        //usersname
        row = FormRowDescriptor(tag: "or", rowType: .Button, title: "OR")
        OR.addRow(row)
        //form.sections.append(OR)
        
        
        //----- LOGIN
        let section1 = FormSectionDescriptor()
        
        section1.headerTitle = "Login"
        
        
        //usersname
        row = FormRowDescriptor(tag: "username", rowType: .Name, title: "Username")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]
        
        section1.addRow(row)
        
        
        //password
        row = FormRowDescriptor(tag: "password", rowType: .Password, title: "Password")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]
        
        section1.addRow(row)
        
        row = FormRowDescriptor(tag: "login", rowType: .Button, title: "Login")
        row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
            
           
            
            if self.valueForTag("username") == nil {
                let alertController = UIAlertController(title: "Error", message: "Username Required", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }else if self.valueForTag("password") == nil {
                let alertController = UIAlertController(title: "Error", message: "Password Required", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                var params = [
                    "username"  : self.valueForTag("username") as! String,
                    "password"  : self.valueForTag("password") as! String
                ]
                
                self.login(params)
            }
            

            
        } as DidSelectClosure
        
        section1.addRow(row)
        
        //form.sections.append(section1)

        
        self.form = form
        
    }
    
    private func register(params: [String: String]){
        print(params)
        
        SwiftSpinner.show("Loading")
        self.tikeApi.checkout(params) { (response) -> Void in
            
            print(response)
            
            SwiftSpinner.hide()
            
            if let errorMsg = response["diagnostic"]["error_msgs"].string {
                print("---------- Error msg ----------")
                self.errorCheckoutMsg = errorMsg.stringByReplacingOccurrencesOfString("you are using insecure protocol,", withString: "")
                
                
                print(self.errorCheckoutMsg)
                
                let alertController = UIAlertController(title: "Error", message: self.errorCheckoutMsg, preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
                
            }else{
                
                self.performSegueWithIdentifier("goToPayment", sender: nil)
            }
        }
        
        
    }
    
    private func login(params: [String: String]){
        print(params)
        
    }
}
