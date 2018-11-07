//
//  ModelDataArray.swift
//  On The Map
//
//  Created by X901 on 07/11/2018.
//  Copyright © 2018 X901. All rights reserved.
//

import Foundation

class ModelDataArray {
    static let shared = ModelDataArray()
    
    var usersDataArray = [Any?]()
    
    private init() { }
}
