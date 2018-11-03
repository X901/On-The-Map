//
//  StudentLocations.swift
//  On The Map
//
//  Created by X901 on 03/11/2018.
//  Copyright © 2018 X901. All rights reserved.
//

import Foundation

struct StudentLocations : Decodable {
    let results : [Results]?
}

struct Results : Decodable {
    let createdAt:String?
    let firstName:String?
    let lastName:String?
    let latitude:Double?
    let longitude:Double?
    let mapString:String?
    let mediaURL:String?
    let uniqueKey:String?
    let updatedAt:String?


}


