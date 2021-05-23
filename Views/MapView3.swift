//
//  MapView2.swift
//  AviaryTest2
//
//  Created by Alex on 5/6/21.
//
import SwiftUI
import Foundation
import MapKit

struct MapView3: UIViewRepresentable {
    @ObservedObject var lm = LocationManager()
    @State var bird: Bird
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coords = bird.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.6, longitudeDelta: 0.6)
        let region = MKCoordinateRegion(center: coords, span: span)
        uiView.setRegion(region, animated: true)
        uiView.addAnnotation(bird)
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate{
        var parent: MapView3
        init(_ parent: MapView3){
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
 
    
    
    
}//mapView2 struct
