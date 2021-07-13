//
//  Recipe_List_App.swift
//  Recipe List App
//
//  Created by Lucas Van Tilburg on 27/1/21.
//

import SwiftUI

@main
struct Recipe_List_App: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            RecipeTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
