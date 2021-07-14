//
//  RecipeTabView.swift
//  Recipe List App
//
//  Created by Lucas Van Tilburg on 12/2/21.
//

import SwiftUI

struct RecipeTabView: View {
    var body: some View {
        
        TabView {
            
            RecipeFeaturedView()
                .tabItem {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("Featured")
                    }
                }
            
            RecipeListView()
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("Recipe List")
                    }
                }
            
            AddRecipeView()
                .tabItem {
                    VStack {
                        Image(systemName: "plus.circle")
                        
                        Text("Add Recipe")
                    }
                }
            
        }.environmentObject(RecipeModel())
        
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
