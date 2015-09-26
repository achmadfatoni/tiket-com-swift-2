//
//  TiketAPI.swift
//  tiket-com-swift-2
//
//  Created by Achmad Fatoni on 9/26/15.
//  Copyright © 2015 Achmad Fatoni. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TiketAPI {
    
    //secret key : "64de419c65901078dc7d026194357579"
    
    func getTiketToken() -> Void {
        let urlString = "http://api.sandbox.tiket.com/apiv1/payexpress"
        
        let param = [
            "method" : "getToken",
            "secretkey" : "64de419c65901078dc7d026194357579",
            "output" : "json"
        ]
        Alamofire.request(.GET, urlString, parameters : param)
            .responseJSON { (request, response, result) in
                print("---------- REQUEST ----------")
                print(request)
                print("\n")

                print("---------- RESPONSE ----------")
                print(response)
                print("\n")
                
                print("---------- RESULT ----------")
                print(result)
                debugPrint(result)
                print("\n")
                
                guard let value = result.value else {
                    print("Error: did not receive data")
                    return
                }
                guard result.error == nil else {
                    print("error calling GET on /posts/1")
                    print(result.error)
                    return
                }
                
 

                
                print("---------- TOKEN ----------")
                let json = JSON(value)
                let token = json["token"].string
                print(token!)
        }
    }
}
