//
//  RecipeTabView.swift
//  Recipe List App
//
//  Created by Lucas Van Tilburg on 12/2/21.
//

import SwiftUI

struct RecipeTabView: View {
    
    @State private var tabSelection = 0
    
    var body: some View {
        
        TabView (selection: $tabSelection) {
            
            RecipeFeaturedView()
                .tabItem {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("Featured")
                    }
                }
                .tag(0)
            
            RecipeListView()
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("Recipe List")
                    }
                }
                .tag(1)
            
            AddRecipeView(tabSelection: $tabSelection)
                .tabItem {
                    VStack {
                        Image(systemName: "plus.circle")
                        
                        Text("Add Recipe")
                    }
                }
                .tag(2)
            
        }.environmentObject(RecipeModel())
        
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
