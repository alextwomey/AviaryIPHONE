//
//  CommunityBirds.swift
//  AviaryTest2
//
//  Created by Alex on 5/6/21.
//

import Foundation
import SwiftUI

struct CommunityBirds: View{
    @EnvironmentObject var recentBirds: RecentBirds
    var body: some View{
        NavigationView{
            List(recentBirds.list){bird in
                NavigationLink(destination: BirdDetail2(myBird: bird)){
                    BirdRow2(myBird: bird)
                }//navLink
            }//List
            .navigationTitle("Recently spotted birds near you")
            .font(.title2)
        }//navView
    }//body
}//struct
