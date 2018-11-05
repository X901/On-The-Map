//
//  MapViewController.swift
//  On The Map
//
//  Created by X901 on 02/11/2018.
//  Copyright © 2018 X901. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

   private var annotations = [MKPointAnnotation]()

    private var activityIndicator : UIActivityIndicatorView  = UIActivityIndicatorView()
    
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ActivityIndicator.startActivityIndicator(view: self.view)

        getAllUsersData()

    }
    
    func getAllUsersData(){
        OTMParseClient.sharedInstance().getAllDataFormUsers { (success, usersData, errorString) in
            
            if success {
                
                
                let  newUsersData = usersData as! [Results]
                
                
                self.organizingUsersData(userDataArray: newUsersData)
                
                
            }else {
                Alert.showBasicAlert(on: self, with: errorString!)
            }
        }
    }
    
    func organizingUsersData(userDataArray:[Results]){
        
        
        for i in userDataArray {
           

            if let latitude = i.latitude , let longitude = i.longitude , let first = i.firstName ,let last = i.lastName , let mediaURL = i.mediaURL {
                
                let lat = CLLocationDegrees(latitude)
                let long = CLLocationDegrees(longitude)
                
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)

                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(first) \(last)"
                annotation.subtitle = mediaURL
                
                self.annotations.append(annotation)
     
                

            }
            DispatchQueue.main.async {
                self.mapView.addAnnotations(self.annotations)
                ActivityIndicator.stopActivityIndicator()


            }


            }
 
    }
    
  
    
    @IBAction func refreshNewData(_ sender: Any) {
        ActivityIndicator.startActivityIndicator(view: self.view)

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
    
    
    @IBAction func AddUserLocationTapped(_ sender: Any) {
        
        OTMParseClient.sharedInstance().getuserDataByUniqueKey { (success, usersData, errorString) in
            
            if success {
                
                // if the usersData is not equal nil : that mean the user did already post Location to parse ( get objectId and Ask if he want to update !)
                // but if the usersData is equal nil : that mean the user never post his Location ! (let him post !)
                
                
                
            }else {
                Alert.showBasicAlert(on: self, with: errorString!)
            }
        }
        
    }
    
    
}



extension MapViewController:MKMapViewDelegate{
    
    // MARK: - MKMapViewDelegate
    
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .infoDark)
        }
        else {
            pinView!.annotation = annotation
        }
        
        
        return pinView
    }
    
   
    
    func openUrlInSafari(url:URL){
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)

    }
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {

            if let toOpen = view.annotation?.subtitle! {
                guard let url = URL(string: toOpen) else {return}
                openUrlInSafari(url:url)
            }
        }
    }

    func mapView(mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        if control == annotationView.rightCalloutAccessoryView {
            guard let newUrl = annotationView.annotation?.subtitle else {return}
            guard let stringUrl = newUrl else {return}
            guard let url = URL(string: stringUrl) else {return}
            openUrlInSafari(url:url)

        }
    }
}
