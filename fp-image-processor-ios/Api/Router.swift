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
   static let baseAssetsURL: URL! = baseURL.appendingPathComponent("assets")
   var formedURL: URL { return Router.baseURL.appendingPathComponent(route.path) }
   
   
   // MARK: - Endpoints
   
   case formImage(DB)
   
   
   // MARK: - Routes
   
   var route: (path: String, parameters: [String: Any]?) {
      switch self {
      case .formImage(let request):
         return (path: "/execute", parameters: request.toJSON())
      }
   }
   
   
   // MARK: - Method
   
   var method: HTTPMethod {
      switch self {
      case .formImage:
         return .post
      default:
         return .get
      }
   }
   
   
   // MARK: - Encoding
   
   var encoder: ParameterEncoding {
      switch method {
      default:
         switch self {
         case .formImage:
            return Alamofire.JSONEncoding.default
         default:
            return Alamofire.URLEncoding.default
         }
      }
   }
   
   
   // MARK: - URLRequest
   
   func asURLRequest() throws -> URLRequest {
      var request = URLRequest(url: formedURL)
      
      request.httpMethod = method.rawValue
      
      if encoder is Alamofire.JSONEncoding {
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      }

      return try encoder.encode(request, with: route.parameters ?? [:])
   }
   
}
