//
//  MapView.swift
//  NPF-3
//
//  Created by Alex on 3/24/21.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable{
    @EnvironmentObject var recentBirds: RecentBirds
    @ObservedObject var lm = LocationManager()
    //@Binding var showMapAlert: Bool
    let mapView = MKMapView()
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coords = CLLocationCoordinate2D(latitude: lm.location?.latitude ?? 0, longitude: lm.location?.longitude ?? 0)
        let span = MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8)
        let region = MKCoordinateRegion(center: coords, span: span)
        uiView.setRegion(region, animated: true)
        //print("updating")
        //uiView.removeAnnotations(uiView.annotations)
        
        uiView.addAnnotations(recentBirds.list)
        /*
        for p in recentBirds.list{
            uiView.addAnnotation(p)
        }
 */
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate{
        var parent: MapView
        init(_ parent: MapView){
            self.parent = parent
        }
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
            
        }
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation){

        }
        func mapView(_ mapView:MKMapView, didSelect view:MKAnnotationView){
            let annotation = view.annotation
            print(annotation?.title)
        }
        
        func mapView(_ mapView:MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
            guard annotation is MKPointAnnotation else {return nil}
            let identifier = "Annotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil{
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
            }else{
                annotationView!.annotation = annotation
            }
            return annotationView
        }
       
    }
}
