//
//  FinalAddLocationViewController.swift
//  On The Map
//
//  Created by X901 on 05/11/2018.
//  Copyright © 2018 X901. All rights reserved.
//

import UIKit
import MapKit

class FinalAddLocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var mapString:String?
    var mediaURL:String?
    var latitude:Double?
    var longitude:Double?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createAnnotation()

    }
   
    @IBAction func finishTapped(_ sender: UIButton) {
        if OTMParseClient.sharedInstance().objectId == nil {
            postNewStudentLocation()
        }
    }
    
    func postNewStudentLocation(){
        
        if let fullName = OTMUdacityClient.sharedInstance().fristAndLastName {
        var components = fullName.components(separatedBy: " ")
        if(components.count > 0)
        {
            let firstName = components.removeFirst()
            let lastName = components.joined(separator: " ")
        

          let jsonBody = StudentLocationsBody(results: [ResultsBody(uniqueKey:OTMUdacityClient.sharedInstance().userID! , firstName:firstName, lastName:lastName ,mapString:mapString!,mediaURL:mediaURL! ,latitude:latitude! , longitude:longitude!)])

//            var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
//            request.httpMethod = "POST"
//            request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
//            request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//            request.httpBody = "{\"uniqueKey\": \"\(OTMUdacityClient.sharedInstance().userID!)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(mapString!)\", \"mediaURL\": \"\(mediaURL!)\",\"latitude\": \(latitude!), \"longitude\": \(longitude!)}".data(using: .utf8)
//
//            let session = URLSession.shared
//            let task = session.dataTask(with: request) { data, response, error in
//                if error != nil { // Handle error…
//                    Alert.showBasicAlert(on: self, with: error! as! String)
//                    return
//                }else {
//                    print("success: true!")
//                }
//            }
//            task.resume()
            
            OTMParseClient.sharedInstance().postUserLocation(jsonBody: jsonBody) { (success, errorString) in

                if success {
                    print(success)

                    DispatchQueue.main.async {
                        //self.dismiss(animated: true, completion: nil)
                    }
                }else {
                    Alert.showBasicAlert(on: self, with: errorString!.localizedCapitalized)
                }

            }
        }
        
        }
        
    
    }
    
    func createAnnotation(){
        let annotation = MKPointAnnotation()
        annotation.title = mapString!
        annotation.subtitle = mediaURL!
        annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
        self.mapView.addAnnotation(annotation)
        
    
        //zooming to location
        let coredinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coredinate, span: span)
        self.mapView.setRegion(region, animated: true)
        
    }


}
