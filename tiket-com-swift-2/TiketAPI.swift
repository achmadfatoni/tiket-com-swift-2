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
    let tiketComURL = "http://api.sandbox.tiket.com/"
    let defaults    = NSUserDefaults.standardUserDefaults()
    let output      = "json"
    let token       = NSUserDefaults.standardUserDefaults().objectForKey("token") as? String

    
    func getTiketToken(completion : (token : String) -> Void) {
        let urlString = self.tiketComURL + "apiv1/payexpress"
        
        let param = [
            "method"    : "getToken",
            "secretkey" : "64de419c65901078dc7d026194357579",
            "output"    : self.output
        ]
        Alamofire.request(.GET, urlString, parameters : param)
            .responseJSON { (request, response, result) in
                
                //remove existing token
                //defaults.removeObjectForKey("token")
                
                
                var token = self.defaults.objectForKey("token") as? String
                print("token : ")
                print(token)
                
                if token == nil {
                    print("---------- REQUEST ----------")
                    print(request)
                    print("---------- END REQUEST ----------\n")
                    print("\n")
                    
                    print("---------- RESPONSE ----------")
                    print(response)
                    print("---------- END RESPONSE ----------")

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
                    token = json["token"].string!
                    self.defaults.setObject(token, forKey: "token")
                    
                    print("---------- New Token ----------")
                    token = self.defaults.objectForKey("token") as? String
                    completion(token : token!)
                    
                }else {
                    print("---------- old token ----------")
                    token = self.defaults.objectForKey("token") as? String
                    completion(token : token!)
                }
                
        }
        
    }
    
    
    func getAirport(token: String, completion: (airports: [JSON]) -> Void){
        
        let urlgetAirports  = self.tiketComURL + "flight_api/all_airport"

        let param = [
            "token"     : token,
            "output"    : self.output
        ]
        
        Alamofire.request(.GET, urlgetAirports, parameters : param)
            .responseJSON { (request, response, result) in
                print("---------- REQUEST ----------")
                print(request)
                print("---------- END REQUEST ----------\n")
                print("\n")
                
                print("---------- RESPONSE ----------")
                print(response)
                print("---------- END RESPONSE ----------\n")
                print("\n")
                
                print("---------- RESULT ----------")
                print(result)
                debugPrint(result)
                print("---------- END RESULT ----------\n")
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
                
                //"---------- AIRPORT ----------"
                let json = JSON(value)
                let airports = json["all_airport"]["airport"].array!
                
                completion(airports: airports)
        }

    }
    
    func searchFlight(var params: [String:AnyObject], completion: (flights: JSON) -> Void){
        
        let urlsearchFlight  = self.tiketComURL + "search/flight"
        
        params["token"]     = self.token
        params["output"]    = self.output
        
        print(params)
        
        Alamofire.request(.GET, urlsearchFlight, parameters : params)
            .responseJSON { (request, response, result) in
                print("---------- REQUEST ----------")
                print(request)
                
                print("---------- END REQUEST ----------\n")
                print("\n")
                
                print("---------- RESPONSE ----------")
                print(response)
                print("---------- END RESPONSE ----------\n")
                print("\n")
                
                print("---------- RESULT ----------")
                print(result)
                debugPrint(result)
                print("---------- END RESULT ----------\n")
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
                
                let json = JSON(value)
                
                completion(flights: json)
        }
        
        
    }
    
    func flightData(flightId: String, completion: (flightData: JSON) -> Void){
    
        var urlFlightData = self.tiketComURL + "flight_api/get_flight_data"
        
        var params = [
            "flight_id" : flightId,
            "token"     : self.token as! AnyObject,
            "output"    : self.output
        ]
        
        Alamofire.request(.GET, urlFlightData, parameters : params)
            .responseJSON { (request, response, result) in
                print("---------- REQUEST ----------")
                print(request)
                print("---------- END REQUEST ----------\n")
                print("\n")
                
                print("---------- RESPONSE ----------")
                print(response)
                print("---------- END RESPONSE ----------\n")
                print("\n")
                
                print("---------- RESULT ----------")
                print(result)
                debugPrint(result)
                print("---------- END RESULT ----------\n")
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
                
                
                let json = JSON(value)
                
                completion(flightData: json)
        }

    }
    
    func addOrder(var params: [String:AnyObject], completion: (response: JSON) -> Void){
        
        let urlAddOrder  = self.tiketComURL + "order/add/flight"
        
        params["token"]     = self.token
        params["output"]    = self.output
        
        print(params)
        
        Alamofire.request(.GET, urlAddOrder, parameters : params)
            .responseJSON { (request, response, result) in
                print("---------- REQUEST ----------")
                print(request)
                print("---------- END REQUEST ----------\n")
                print("\n")
                
                print("---------- RESPONSE ----------")
                print(response)
                print("---------- END RESPONSE ----------\n")
                print("\n")
                
                print("---------- RESULT ----------")
                print(result)
                debugPrint(result)
                print("---------- END RESULT ----------\n")
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
                
                let json = JSON(value)

                completion(response: json)
        }
        
        
    }
    
    func cart(completion : (orders : JSON) -> Void){
        let orderUrl  = self.tiketComURL + "order"
        
        var params = [
            "token"     : self.token as! AnyObject,
            "output"    : self.output
        ]
        
        Alamofire.request(.GET, orderUrl, parameters : params)
            .responseJSON { (request, response, result) in
                print("---------- REQUEST ----------")
                print(request)
                print("---------- END REQUEST ----------\n")
                print("\n")
                
                print("---------- RESPONSE ----------")
                print(response)
                print("---------- END RESPONSE ----------\n")
                print("\n")
                
                print("---------- RESULT ----------")
                print(result)
                debugPrint(result)
                print("---------- END RESULT ----------\n")
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
                
                let json = JSON(value)
                
                completion(orders: json)
        }
    }
    
    
    func deleteOrder(orderDetailId: String, completion: (response: JSON) -> Void){
        
        let urlAddOrder  = self.tiketComURL + "order/delete_order"
        
        var params = [
            "order_detail_id"   : orderDetailId,
            "token"             : self.token as! AnyObject,
            "output"            : self.output
        ]
        
        print(params)
        
        Alamofire.request(.GET, urlAddOrder, parameters: params)
            .responseJSON { (request, response, result) in
                print("---------- REQUEST ----------")
                print(request)
                print("---------- END REQUEST ----------\n")
                print("\n")
                
                print("---------- RESPONSE ----------")
                print(response)
                print("---------- END RESPONSE ----------\n")
                print("\n")
                
                print("---------- RESULT ----------")
                print(result)
                debugPrint(result)
                print("---------- END RESULT ----------\n")
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
                
                let json = JSON(value)
                
                completion(response: json)
        }
        
        
    }

    func listCountry(completion : (countries : JSON) -> Void){

        let listCountryUrl = self.tiketComURL + "general_api/listCountry"

        let params = [
                "token"     : self.token as! AnyObject,
                "output"    : self.output
        ]

        Alamofire.request(.GET, listCountryUrl, parameters: params)
        .responseJSON { (request, response, result) in
            print("---------- REQUEST ----------")
            print(request)
            print("---------- END REQUEST ----------\n")
            print("\n")

            print("---------- RESPONSE ----------")
            print(response)
            print("---------- END RESPONSE ----------\n")
            print("\n")

            print("---------- RESULT ----------")
            print(result)
            debugPrint(result)
            print("---------- END RESULT ----------\n")
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

            let json = JSON(value)

            completion(countries: json)
        }

    }
    
    func checkoutRequest(orderId: String, completion: (response: JSON)-> Void ){
        let checkoutRequestUlr = self.tiketComURL + "order/checkout/\(orderId)/IDR"
        
        let params = [
            "token"     : self.token as! AnyObject,
            "output"    : self.output,
        ]
        
        Alamofire.request(.GET, checkoutRequestUlr, parameters: params)
            .responseJSON { (request, response, result) in
                print("---------- REQUEST ----------")
                print(request)
                print("---------- END REQUEST ----------\n")
                print("\n")
                
                print("---------- RESPONSE ----------")
                print(response)
                print("---------- END RESPONSE ----------\n")
                print("\n")
                
                print("---------- RESULT ----------")
                print(result)
                debugPrint(result)
                print("---------- END RESULT ----------\n")
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
                
                let json = JSON(value)
                
                completion(response: json)
        }

    }
    
    
    func checkout(var params: [String:String], completion: (response: JSON) -> Void) {
        let checkoutUlr = self.tiketComURL + "checkout/checkout_customer"
        
        params["token"] = self.token
        params["output"] = self.output
        params["saveContinue"] = "2"
        
        Alamofire.request(.GET, checkoutUlr, parameters: params)
            .responseJSON { (request, response, result) in
                print("---------- REQUEST ----------")
                print(request)
                print("---------- END REQUEST ----------\n")
                print("\n")
                
                print("---------- RESPONSE ----------")
                print(response)
                print("---------- END RESPONSE ----------\n")
                print("\n")
                
                print("---------- RESULT ----------")
                print(result)
                debugPrint(result)
                print("---------- END RESULT ----------\n")
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
                
                let json = JSON(value)
                
                completion(response: json)
        }
    }
}
