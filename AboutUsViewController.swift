//
//  AboutUsViewController.swift
//  SkinCare Project
//
//  Created by TDI Student on 28.9.22.
//


import UIKit
import MapKit
import CoreLocation

class AboutUsViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var aboutUsImg: UIImageView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ourLocation()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.mapType = .satellite
        mapView.layer.cornerRadius = 7
        mapView.layer.borderColor = UIColor.white.cgColor
        mapView.layer.borderWidth = 6
        // Do any additional setup after loading the view.
    }

 
 
    
    func ourLocation(){
        let prishtinaCenter = MKPointAnnotation()
        prishtinaCenter.title = "Our Location"
        prishtinaCenter.coordinate = CLLocationCoordinate2D(latitude: 42.6629, longitude: 21.1655)
        mapView.addAnnotation(prishtinaCenter)
        
        let mitrovicaCenter = MKPointAnnotation()
        mitrovicaCenter.title = "Our Location"
        mitrovicaCenter.coordinate = CLLocationCoordinate2D(latitude: 42.8914, longitude: 20.8660)
        mapView.addAnnotation(mitrovicaCenter)
        
        let gjilanCenter = MKPointAnnotation()
        gjilanCenter.title = "Our Location"
        gjilanCenter.coordinate = CLLocationCoordinate2D(latitude: 42.4635, longitude: 21.4694)
        mapView.addAnnotation(gjilanCenter)
           
        let gjakovaCenter = MKPointAnnotation()
        gjakovaCenter.title = "Our Location"
        gjakovaCenter.coordinate = CLLocationCoordinate2D(latitude: 42.3844, longitude: 20.4285)
        mapView.addAnnotation(gjakovaCenter)
           
        let pejaCenter = MKPointAnnotation()
        pejaCenter.title = "Our Location"
        pejaCenter.coordinate = CLLocationCoordinate2D(latitude: 42.6593, longitude: 20.2887)
        mapView.addAnnotation(pejaCenter)
        
        let region = MKCoordinateRegion(center: mitrovicaCenter.coordinate, latitudinalMeters: 150000, longitudinalMeters: 80000)
        mapView.setRegion(region, animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinates: CLLocationCoordinate2D = manager.location!.coordinate
        
        mapView.showsUserLocation = true
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = "You Are Here"
        
    }
}
