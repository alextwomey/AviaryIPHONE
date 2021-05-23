//
//  AviaryTest2App.swift
//  AviaryTest2
//
//  Created by Alex on 5/6/21.
//

import SwiftUI

@main
struct AviaryTest2App: App {
    var body: some Scene {
        let recentBirds = RecentBirds()
        let persistanceController = PersistenceController.shared
        WindowGroup {
            ContentView().environmentObject(recentBirds)
                .environment(\.managedObjectContext,persistanceController.container.viewContext)
        }
    }
}
