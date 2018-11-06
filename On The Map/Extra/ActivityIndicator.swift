//
//  ActivityIndicator.swift
//  On The Map
//
//  Created by X901 on 04/11/2018.
//  Copyright © 2018 X901. All rights reserved.
//

import Foundation
import UIKit

struct ActivityIndicator {
    
    private static var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    static func startActivityIndicator(view:UIView){
        
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    
    static func stopActivityIndicator(){
        activityIndicator.stopAnimating()
    }
    
}
