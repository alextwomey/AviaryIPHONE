//
//  MyBirds.swift
//  AviaryTest2
//
//  Created by Alex on 5/6/21.
//

import Foundation
import CoreLocation
import SwiftUI
import Alamofire

class RecentBirds: ObservableObject, Identifiable{
    @Published var list: [Bird2] = []
    @ObservedObject var lm = LocationManager()
    @State var zip = ""
    let id = UUID()
    init(){
        getData()
        
        //list = lit of birdstaken from eBird API
    }//init
    func getData(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            let lat = (self.lm.location?.latitude)
            let lng = (self.lm.location?.longitude)
            let myLat:String = String(format: "%.2f",lat!)
            let myLng:String = String(format: "%.2f",lng!)
            //print(zip)
            let url1 = "https://api.ebird.org/v2/data/obs/geo/recent?lat=\(myLat)&lng=\(myLng)"
            //print(url1)
            //"X-eBirdApiToken:",forHTTPHeaderField: "reu85ru01kk2"
            let param = ["key": "reu85ru01kk2"]
            AF.request(url1, parameters: param).responseJSON { response in
                //debugPrint(response)
                guard let itemsData = response.data else{
                    return
                }
                //print(itemsData)
                do{
                    let decoder = JSONDecoder()
                    let items = try decoder.decode([Item].self, from: itemsData)
                    //print("ITEMS HERE: \(items)")
                    for index in 0...items.count-1{
                        let tempBird = Bird2(birdName: items[index].comName, sciName: items[index].sciName, howMany: String(items[index].howMany ?? 1), lat: items[index].lat, long: items[index].lng, obsDate: items[index].obsDt)
                        //list.append(tempBird)
                        //print(tempBird)
                        self.list.append(tempBird)
                    }
                }catch{
                    print(error)
                }
            }//response
                        
            
        }//dispatchqueue

    }//get data
}//myBirds
struct Item: Codable{
    let comName: String
    let howMany: Int?
    let lat: Double
    let lng: Double
    let obsDt: String
    let sciName: String
}
