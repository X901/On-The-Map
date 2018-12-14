//
//  User.swift
//  On The Map
//
//  Created by X901 on 01/11/2018.
//  Copyright © 2018 X901. All rights reserved.
//

import Foundation

//Mark: Udacity session JSON Body
struct UdacitySessionBody : Codable {
    let udacity : Udacity
}

struct Udacity : Codable {
    let username:String
    let password:String
}

//Mark: Udacity session JSON Response
struct UdacitySessionResponse : Codable {
    let account : Account
    let session : Session
    
}

struct Account : Codable {
    let registered : Bool?
    let key : String?
}

struct SessionDelete : Codable {
    let session : Session
}

struct Session : Codable {
    let id : String?
    let expiration : String?
}

//Mark: User Data (Frist and Last Name)

struct UdacityUserData : Codable {
    let nickname : String?

}





