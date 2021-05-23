//
//  Glossary.swift
//  AviaryTest2
//
//  Created by Alex on 5/6/21.
//

import Foundation
import SwiftUI

struct Glossary:View{
    //@State var myBirds: FetchedResults<Bird>
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Bird.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Bird.birdName, ascending: true)])
    var birdItems: FetchedResults<Bird>
    
    var body: some View{
        NavigationView{
            List(birdItems){bird in
                NavigationLink(destination: BirdDetail(myBird: bird)){
                    BirdRow(myBird: bird)
                }//navLink
            }//List
            .navigationTitle("Your Birds")
        }//navView
    }//body
}//struct




