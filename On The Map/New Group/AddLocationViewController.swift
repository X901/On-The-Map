//
//  AddLocationViewController.swift
//  On The Map
//
//  Created by X901 on 05/11/2018.
//  Copyright © 2018 X901. All rights reserved.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController {
    
    
    @IBOutlet weak var yourLocationTextfield: UITextField!
    
    @IBOutlet weak var yourWebsiteTextfield: UITextField!
    
    var latitude : Double?
    var longitude : Double?
    
    func returnBackToRoot() {
        DispatchQueue.main.async {
            if let navigationController = self.navigationController {
                navigationController.popToRootViewController(animated: true)
            }
        }
        
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        returnBackToRoot()
        
    }
    
    
    @IBAction func FindLocation(_ sender: UIButton) {
        
        guard let websiteLink = yourLocationTextfield.text else {return}
        
        if !websiteLink.contains("http://"){
            Alert.showBasicAlert(on: self, with: "The Website Should Contains \"http://\" ")
        }else {
            if yourLocationTextfield.text != "" && yourWebsiteTextfield.text != "" {
                
                let searchRequest = MKLocalSearch.Request()
                searchRequest.naturalLanguageQuery = yourLocationTextfield.text
                
                let activeSearch = MKLocalSearch(request: searchRequest)
                
                activeSearch.start { (response, error) in
                    
                    if error != nil {
                        print("Location Error : \(error!.localizedDescription)")
                        Alert.showBasicAlert(on: self, with: "Location Not Found")
                    }else {
                        self.latitude = response?.boundingRegion.center.latitude
                        self.longitude = response?.boundingRegion.center.longitude
                        
                        self.performSegue(withIdentifier: "toFinalAddLocation", sender: nil)
                        
                    }
                    
                }
                
                
                
            }else {
                DispatchQueue.main.async {
                    Alert.showBasicAlert(on: self, with: "You need to enter your Location & your URL ! ")
                }
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFinalAddLocation"{
            let vc = segue.destination as! FinalAddLocationViewController
            
            vc.mapString = yourLocationTextfield.text
            vc.mediaURL = yourWebsiteTextfield.text
            vc.latitude = self.latitude
            vc.longitude = self.longitude
            
        }
        
    }
    
    
    
}
