//
//  User.swift
//  On The Map
//
//  Created by X901 on 01/11/2018.
//  Copyright © 2018 X901. All rights reserved.
//

import Foundation

//Mark: Udacity session JSON Body
struct UdacitySessionBody : Encodable {
    let udacity : Udacity
}

struct Udacity : Encodable {
    let username:String
    let password:String
}

//Mark: Udacity session JSON Response
struct UdacitySessionResponse : Decodable {
    let account : Account
    let session : Session
    
}

struct Account : Decodable {
    let registered : Bool?
    let key : String?
}

struct SessionDelete : Decodable {
    let session : Session
}

struct Session : Decodable {
    let id : String?
    let expiration : String?
}

//Mark: User Data (Frist and Last Name)

struct UdacityUserData : Decodable {
    let user : User
}

struct User : Decodable {
    let first_name : String?
    let last_name : String?

}


