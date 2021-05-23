//
//  Bird.swift
//  AviaryTest2
//
//  Created by Alex on 5/6/21.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI

class Bird2: MKPointAnnotation, Identifiable{
    //@State public var id: UUID
    @State public var birdName: String
    @State public var sciName: String
    @State public var howMany: String? = ""
    @State public var lat: Double
    @State public var long: Double
    @State public var obsDate:String
    override var coordinate: CLLocationCoordinate2D{
        get{
            return CLLocation(latitude: lat, longitude: long).coordinate
        }//get
        set{
            
        }
    }//coordinate
    init(birdName:String,sciName:String,howMany:String?,lat:Double,long:Double,obsDate:String){
        self.birdName = birdName
        self.sciName = sciName
        self.howMany = howMany
        self.lat = lat
        self.long = long
        self.obsDate = obsDate
        
    }
    override var description: String{
        return "{\n\t Bird Name: \(birdName) (\(sciName )\n\tlocation: \(String(describing: CLLocation(latitude: lat, longitude: long)))\n}"
    }
    override var title: String?{
        get{
            return birdName
        }
        set{
            
        }
    }//title
    override var subtitle: String?{
        get{
            return sciName
        }
        set{
            
        }
    }//subtitle
    
}//class


