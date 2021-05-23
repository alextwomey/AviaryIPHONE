//
//  Bird.swift
//  AviaryTest2
//
//  Created by Alex on 5/6/21.
//

import Foundation
import CoreLocation
import MapKit
import CoreData

class Bird: NSManagedObject, MKAnnotation, Identifiable{
    @NSManaged public var id: UUID
    @NSManaged public var birdName: String
    @NSManaged public var sciName: String
    @NSManaged public var howMany: String
    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var obsDate:String
    var coordinate: CLLocationCoordinate2D{
        get{
            return CLLocation(latitude: lat, longitude: long).coordinate
        }//get
    }//coordinate
    
    override var description: String{
        return "{\n\t Bird Name: \(birdName) (\(sciName )\n\tlocation: \(String(describing: CLLocation(latitude: lat, longitude: long)))\n}"
    }
    var title: String?{
        get{
            return birdName
        }
    }//title
    var subtitle: String?{
        get{
            return sciName
        }
    }//subtitle
    
}//class


