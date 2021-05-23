//
//  ContentView.swift
//  AviaryTest2
//
//  Created by Alex on 5/6/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Bird.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Bird.birdName, ascending: true)])
    var birdItems: FetchedResults<Bird>
    @State var loading:Bool = true
    
    @ObservedObject var lm = LocationManager()
    //latitude = lm.location.latitude ?? 0
    @EnvironmentObject var recentBirds: RecentBirds
    
    @State private var selection = 3

    var body: some View {
        let persistanceController = PersistenceController.shared
        ZStack{
            
        
            TabView(selection: $selection){
                MapView()
                    .edgesIgnoringSafeArea(.all)
                    .tabItem{
                        Image(systemName: "map")
                            Text("Map")
                    }//tabItem
                    .tag(1)
                Glossary()
                    .tabItem{
                        Image(systemName: "book")
                        Text("Your Birds")
                    }//tabitem
                    .tag(2)
                Camera()
                    .environment(\.managedObjectContext,persistanceController.container.viewContext)
                    .tabItem{
                        Image(systemName: "plus.circle")
                        Text("New Bird")
                    }//tabitem
                    .tag(3)
                CommunityBirds()
                    .tabItem{
                        Image(systemName: "globe")
                        Text("Community Birds")
                    }//tabitem
                    .tag(4)
                AboutView()
                    .tabItem{
                        Image(systemName: "wrench")
                        Text("About")
                    }//tabitem
                    .tag(5)
                
            }//tabView
            if(loading){
                LoadingScreen()
                    .onAppear(){
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                            loading = false;
                        }
                    }
            }
            
        }//zstack
    }//body
}//content View
struct LoadingScreen: View{
    var body: some View{
        Image("spl")
    }
    
}
struct AboutView: View{

    var body: some View{
        
            VStack{
                Text("Aviary: Bird Watching Companion App By Alex Twomey")
                    .font(.title)
                    .frame(width:250)
                    .padding()
                    .background(Color.purple.opacity(0.4))
                    .cornerRadius(25)
                Text("Final project for Mobile Application Development 1")
                    .font(.title)
                    .frame(width:250)
                    .padding()
                    .background(Color.purple.opacity(0.4))
                    .cornerRadius(25)
            }
            
            
        
    }//body
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RecentBirds())
    }//previews
}//contentPreview
