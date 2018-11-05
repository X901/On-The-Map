//
//  UsersDataTableViewController.swift
//  On The Map
//
//  Created by X901 on 04/11/2018.
//  Copyright © 2018 X901. All rights reserved.
//

import UIKit
import SafariServices

class UsersDataTableViewController: UIViewController {

    @IBOutlet weak var usersDataTableview: UITableView!
    
    var usersDataArray = [Any?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllUsersData()
    }
    


    func getAllUsersData(){
        
        ActivityIndicator.startActivityIndicator(view: self.view)
        
        OTMParseClient.sharedInstance().getAllDataFormUsers { (success, usersData, errorString) in
            
            if success {
                
                guard let newUsersData = usersData else {return}
                
                self.usersDataArray = newUsersData as! [Results]
                
                DispatchQueue.main.async {
                    ActivityIndicator.stopActivityIndicator()

                    self.usersDataTableview.reloadData()
                }
                
            }else {
                DispatchQueue.main.async {
                    ActivityIndicator.stopActivityIndicator()
                }
                Alert.showBasicAlert(on: self, with: errorString!)

                
            }
            
            }
        }
    


    @IBAction func refreshTapped(_ sender: UIBarButtonItem) {
        getAllUsersData()
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        OTMUdacityClient.sharedInstance().deleteSession { (success, sessionID, errorString) in
            
            DispatchQueue.main.async {
                if success {
                    self.dismiss(animated: true, completion: nil)
                    
                }else {
                    Alert.showBasicAlert(on: self, with: errorString!)
                }
            }
            
        }
        
    }
    
    
}

extension UsersDataTableViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return usersDataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersDataCell") as! UsersDataTableViewCell

        
        cell.fillCell(usersData: usersDataArray[indexPath.row] as! Results)
        
        return cell
        
    }
    
    
}

extension UsersDataTableViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let dataArray = usersDataArray as! [Results]
        
        if let urlString = dataArray[indexPath.row].mediaURL,
          let url = URL(string: urlString){
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)

    }
    }
}
