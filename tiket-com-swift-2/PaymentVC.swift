//
//  PaymentVC.swift
//  tiket-com-swift-2
//
//  Created by Achmad Fatoni on 11/5/15.
//  Copyright © 2015 Achmad Fatoni. All rights reserved.
//

import UIKit

class PaymentVC: UITableViewController {

    var tiketApi = TiketAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tiketApi.payment { (response) -> Void in
            print(response)
        }

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
