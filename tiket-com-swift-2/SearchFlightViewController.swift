//
//  SearchFlightViewController.swift
//  tiket-com-swift-2
//
//  Created by Achmad Fatoni on 10/16/15.
//  Copyright © 2015 Achmad Fatoni. All rights reserved.
//

import UIKit
import SwiftForms

class SearchFlightViewController: FormViewController {

    struct Static {
        static let nameTag = "name"
        static let passwordTag = "password"
        static let lastNameTag = "lastName"
        static let jobTag = "job"
        static let emailTag = "email"
        static let URLTag = "url"
        static let phoneTag = "phone"
        static let enabled = "enabled"
        static let check = "check"
        static let segmented = "segmented"
        static let picker = "picker"
        static let birthday = "birthday"
        static let categories = "categories"
        static let button = "button"
        static let stepper = "stepper"
        static let slider = "slider"
        static let textView = "textview"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .Plain, target: self, action: "submit:")
    }
    
    /// MARK: Actions
    
    func submit(_: UIBarButtonItem!) {
        
//        let message = self.form.formValues().description
        
//        let alert: UIAlertView = UIAlertView(title: "Form output", message: message, delegate: nil, cancelButtonTitle: "OK")
//        
//        alert.show()
    }
    
    /// MARK: Private interface
    
    private func loadForm() {
        
        let form = FormDescriptor()
        
        form.title = "Search Flight"
        
        let section1 = FormSectionDescriptor()
        //departure airport
        var row: FormRowDescriptor! = FormRowDescriptor(tag: "departureAirportCode", rowType: .MultipleSelector, title: "Departure")
        row.configuration[FormRowDescriptor.Configuration.Options] = [0, 1, 2, 3, 4]
        row.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = false
        row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
            switch( value ) {
            case 0:
                return "Restaurant"
            case 1:
                return "Pub"
            case 2:
                return "Shop"
            case 3:
                return "Hotel"
            case 4:
                return "Camping"
            default:
                return nil
            }
            } as TitleFormatterClosure
        
        section1.addRow(row)
        
        // arrival airport
        row = FormRowDescriptor(tag: "departureAirportCode", rowType: .MultipleSelector, title: "Arrival")
        row.configuration[FormRowDescriptor.Configuration.Options] = [0, 1, 2, 3, 4]
        row.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = false
        row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
            switch( value ) {
            case 0:
                return "Restaurant"
            case 1:
                return "Pub"
            case 2:
                return "Shop"
            case 3:
                return "Hotel"
            case 4:
                return "Camping"
            default:
                return nil
            }
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
        
        row = FormRowDescriptor(tag: "infantPassenger", rowType: .Number, title: "infant")
        row.value = "0"
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section2.addRow(row)
        
        form.sections = [section1, section2]
        
        self.form = form
    }
}
