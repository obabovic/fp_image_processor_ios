//
//  APIEntity.swift
//  RaceCap
//
//  Created by Ognjen Babovic on 13/8/18.
//  Copyright © 2018 Comparativ. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol APIEntity {
   init(fromJSON json: JSON)
}
