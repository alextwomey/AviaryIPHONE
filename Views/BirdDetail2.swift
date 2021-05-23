//
//  BirdDetail.swift
//  AviaryTest2
//
//  Created by Alex on 5/6/21.
//

import Foundation
import SwiftUI

struct BirdDetail2: View{
    @State var myBird: Bird2
    
    var body: some View{
        VStack(alignment: .leading){
            //CircleImage(imageUrl: parkListItem.getImageLink())
            
            Text(myBird.birdName)
                .font(.title)
            
            HStack{
                Text(myBird.sciName)
                Spacer()
                Text(myBird.obsDate)
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            Divider()
            VStack(alignment: .center){
                NavigationLink(destination: MapView2(bird: myBird)){Text("Show On Map")}
            }//vstack
        }//vstack
        .padding()
        Spacer()
    }//view
}//struct
