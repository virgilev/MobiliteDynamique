//
//  ViewController.swift
//  MobiliteDynamique
//
//  Created by Pierre Bathellier on 02/10/2017.
//  Copyright © 2017 Pierre Bathellier. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class ViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var dataSwitch: UISwitch!
    
    @IBOutlet weak var dataLabel: UITextField!
    @IBAction func plusButton(_ sender: Any) {
    }
    
    public let locationManager = LocationManager.shared
    
    public var locationList: [CLLocation] = []
    
    
    public var distance = Measurement(value: 0, unit: UnitLength.meters)
    
        
    @IBAction func changeLabelData() {
        
        if dataSwitch.isOn {
            dataLabel.text = "Oui"
            startCollectLocation()
            
        }
        else {
            dataLabel.text = "Non"
            stopCollectLocation()
        }
        
    }
    
    private func startCollectLocation() {
        //loadView()
        startLocationUpdates()
    }
    
    private func startLocationUpdates() {
        locationManager.delegate = self
        locationManager.activityType = .fitness
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
    }
    
    
    private func stopCollectLocation() {
        locationManager.stopUpdatingLocation()
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(location: initialLocation)
        // show artwork on map
        let artwork = Artwork(title: "King David Kalakaua",
                              locationName: "Waikiki Gateway Park",
                              discipline: "Sculpture",
                              coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        
        mapView.addAnnotation(artwork)
        mapView.delegate = self

    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
/*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 */


}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }
            
            if let lastLocation = locationList.last {
                let delta = newLocation.distance(from: lastLocation)
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
            }
            
            locationList.append(newLocation)
            print(newLocation)
        }
    }
}

/*

extension ViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case details = "BusMapController"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .details:
            let destination = segue.destination as! BusMapViewController
        }
    }
    
    
    
}
 */

