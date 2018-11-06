//
//  UsersDataTableViewCell.swift
//  On The Map
//
//  Created by X901 on 04/11/2018.
//  Copyright © 2018 X901. All rights reserved.
//

import UIKit

class UsersDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    
    func fillCell(usersData: Results) {
        
        if let frist = usersData.firstName , let last = usersData.lastName , let url = usersData.mediaURL {
            
            fullNameLabel.text = "\(frist) \(last)"
            urlLabel.text = "\(url)"
            
        }
    }
    
    
    
}
