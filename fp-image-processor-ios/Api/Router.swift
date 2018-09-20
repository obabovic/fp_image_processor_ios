//
//  Router.swift
//  fp-image-processor-ios
//
//  Created by Ognjen Babovic on 9/20/18.
//  Copyright © 2018 Ognjen Babovic. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
   static let baseURL: URL! = URL(string: "http://localhost:9000")
   
   var formedURL: URL { return Router.baseURL.appendingPathComponent(route.path) }
   
   
   // MARK: - Endpoints
   
   case execute(DB)
   
   
   // MARK: - Routes
   
   var route: (path: String, parameters: [String: Any]?) {
      switch self {
      case .execute(let request):
         return (path: "srv/json/login", parameters: request.toJSON())
      }
   }
   
   
   // MARK: - Method
   
   var method: HTTPMethod {
      switch self {
      default:
         return .post
      }
   }
   
   
   // MARK: - Encoding
   
   var encoder: ParameterEncoding {
      switch method {
      default:
         switch self {
         case .execute:
            return Alamofire.JSONEncoding.default
         default:
            return Alamofire.URLEncoding.default
         }
      }
   }
   
   
   // MARK: - URLRequest
   
   func asURLRequest() throws -> URLRequest {
      var request = URLRequest(url: formedURL)
      var parameters = route.parameters
      
      request.httpMethod = method.rawValue
      request.setValue("application/json", forHTTPHeaderField: "Accepts")
      
      if encoder is Alamofire.JSONEncoding {
         request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
      }

      return try encoder.encode(request, with: parameters ?? [:])
   }
   
}
