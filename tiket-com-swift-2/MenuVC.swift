//
//  MenuVC.swift
//  tiket-com-swift-2
//
//  Created by Achmad Fatoni on 11/2/15.
//  Copyright © 2015 Achmad Fatoni. All rights reserved.
//

import UIKit

class MenuVC: UITableViewController {
    
    var tiketApi = TiketAPI()

    //login button
    
    @IBOutlet weak var myOrder: UITableViewCell!
    @IBOutlet weak var myProfile: UITableViewCell!
    @IBOutlet weak var changePassword: UITableViewCell!
    @IBOutlet weak var logout: UITableViewCell!
    
    //not login button
    @IBOutlet weak var login: UITableViewCell!
    @IBOutlet weak var register: UITableViewCell!
    @IBOutlet weak var forgetPassword: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.tiketApi.isLogin() {
            //row 2
            self.login.hidden = true
            //row 3
            self.register.hidden = true
            //row 4
            self.forgetPassword.hidden = true
        }else{
            
            self.myOrder.hidden = true
            self.myProfile.hidden = true
            self.changePassword.hidden = true
            self.logout.hidden = true
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if self.tiketApi.isLogin() {
            if indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 {
                return 0
            }
        }
        
        return 44
    }

}
