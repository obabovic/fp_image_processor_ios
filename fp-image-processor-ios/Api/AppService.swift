//
//  AppService.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/20/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//


import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

class AppService {
   private init() {}

   /**
    Executes the request with all parameters
    
    - parameter request: wrapper for all data
    - returns: A Promise with url of destination image
    */
   
   static func formImage(request: DB) -> Promise<String?> {
      return Promise { seal in
         Alamofire.request(Router.formImage(request))
            .validate()
            .responseJSON { response in
               switch response.result {
               case .success(let data):
                 seal.fulfill(JSON(data).string)
               case .failure(let err):
                 seal.reject(err)
               }
         }
      }
   }
   
   /**
    Loads the previously saved configuration
    
    - parameter request: wrapper for all data
    - returns: A Promise with url of destination image
    */
   
   static func loadConfiguration() -> Promise<DB?> {
      return Promise { seal in
         Alamofire.request(Router.loadConfiguration())
            .validate()
            .responseJSON { response in
               switch response.result {
               case .success(let data):
                  seal.fulfill(DB(fromJSON: JSON(data)))
               case .failure(let err):
                  seal.reject(err)
               }
         }
      }
   }
}
