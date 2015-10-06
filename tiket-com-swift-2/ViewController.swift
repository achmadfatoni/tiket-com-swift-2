//
//  ViewController.swift
//  tiket-com-swift-2
//
//  Created by Achmad Fatoni on 9/26/15.
//  Copyright © 2015 Achmad Fatoni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let api = TiketAPI()
        api.getTiketToken({(token) in
            print("token : " + token)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

