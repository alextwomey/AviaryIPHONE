//
//  LocationManager.swift
//  AviaryTest2
//
//  Created by Alex on 5/6/21.
//

import Foundation
import Combine
import CoreLocation

class LocationManager: NSObject, ObservableObject{
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @Published var status: CLAuthorizationStatus?{
        willSet { objectWillChange.send() }
    }
    @Published var location: CLLocation? {
        willSet { objectWillChange.send() }
    }
    @Published var placemark: CLPlacemark?{
        willSet{ objectWillChange.send() }
    }
    
    override init(){
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }//init
    private func geocode(){
        guard let location = self.location else { return }
        geocoder.reverseGeocodeLocation(location, completionHandler:{ (places, error) in
            if error == nil{
                self.placemark = places?[0]
                //print("it should be set")
            }else{
                self.placemark = nil
            }//else
        })//geocoder
    }//geocode
}//class

extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        self.status = status
    }//locationmanager
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last else {return}
        self.location = location
        self.geocode()
    }//locgtionManager
}//extension

extension CLLocation{
    var latitude: Double{
        return self.coordinate.latitude
    }
    var longitude: Double{
        return self.coordinate.longitude
    }
}//extension
