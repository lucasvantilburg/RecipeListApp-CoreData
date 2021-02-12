//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Lucas Van Tilburg on 27/1/21.
//

import Foundation

class RecipeModel:ObservableObject {
    
    @Published var recipes = [Recipe]()
    
    init() {
        
        //create an instance of data service and get the recipe data
        self.recipes = DataService.getLocalData()
    }
}
