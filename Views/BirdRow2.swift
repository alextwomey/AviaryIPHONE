//
//  BirdRow.swift
//  AviaryTest2
//
//  Created by Alex on 5/6/21.
//

import Foundation
import SwiftUI

struct BirdRow2: View{
    @State var myBird: Bird2
    var body: some View{
        VStack(alignment: .leading){
            Text(myBird.birdName)
                .font(.title)
            Text(myBird.sciName)
                .font(.caption)
        }
        
    }//view
}//struct
