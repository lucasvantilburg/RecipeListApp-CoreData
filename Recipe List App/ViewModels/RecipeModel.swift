//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Lucas Van Tilburg on 27/1/21.
//

import Foundation
import UIKit

class RecipeModel:ObservableObject {
    
    //reference to the managed object context
    let managedObjectContext = PersistenceController.shared.container.viewContext
    
    @Published var recipes = [Recipe]()
    
    init() {
        
        //check if we have preloaded the data into core data
        checkLoadedData()
    }
    
    func checkLoadedData() {
        
        //check local storage for the flag
        let status = UserDefaults.standard.bool(forKey: Constants.isDataPreloaded)
        
        //if it is false- parse json data and preload into core data
        if status == false {
            preloadLocalData()
        }
    }
    
    func preloadLocalData() {
        
        //parse local JSON file
        let localRecipes = DataService.getLocalData()
        
        //create core data objects
        for r in localRecipes {
            //create a core data object
            let recipe = Recipe(context: managedObjectContext)
            
            //set its properties
            recipe.id = UUID()
            recipe.name = r.name
            recipe.featured = r.featured
            recipe.image = UIImage(named: r.image)?.jpegData(compressionQuality: 1.0)
            recipe.summary = r.description
            recipe.prepTime = r.prepTime
            recipe.cookTime = r.cookTime
            recipe.totalTime = r.totalTime
            recipe.servings = r.servings
            recipe.highlights = r.highlights
            recipe.directions = r.directions
            
            //set the ingredients
            for i in r.ingredients {
                //create a core data ingredient object
                let ingredient = Ingredient(context: managedObjectContext)
                
                //set its properties
                ingredient.id = UUID()
                ingredient.name = i.name
                ingredient.num = i.num ?? 1
                ingredient.denom = i.denom ?? 1
                ingredient.unit = i.unit
                
                //add ingredient to recipe
                recipe.addToIngredients(ingredient)
            }
        }
        
        //save into core data
        do {
            try managedObjectContext.save()
            
            //set the local storage flag
            UserDefaults.standard.setValue(true, forKey: Constants.isDataPreloaded)
        }
        catch {
            //couldn't load the data
        }
        
        //set local storage flag
    }
    
    static func getPortion(ingredient:Ingredient, recipeServings:Int, targetServings:Int) -> String {
        
        var portion = ""
        var numerator = ingredient.num
        var denominator = ingredient.denom
        var wholeParts = 0
        
        
            
        //Get a single serving size
        denominator *= recipeServings
        
        //Get target portion
        numerator *= targetServings
        
        //Reduce fraction by GCD
        let divisor = Rational.greatestCommonDivisor(numerator, denominator)
        
        numerator /= divisor
        denominator /= divisor
        
        //Get whole portion if num > den
        if (numerator >= denominator) {
            wholeParts = numerator / denominator
            numerator = numerator % denominator
            
            //Append to string
            portion += String(wholeParts)
        }
        
        //Express remainder as fraction
        if (numerator > 0) {
            
            //Add space if there are whole portions
            portion += wholeParts > 0 ? " ": ""
            
            //append remainder as fraction to string
            portion += "\(numerator)/\(denominator)"
        }
        
        
        if var unit = ingredient.unit {
            //calculate appropriate suffix
            if (wholeParts > 1) || (wholeParts == 1 && numerator > 0) {
                if unit.suffix(2) == "ch" {
                    unit += "es"
                }
                else if unit.suffix(1) == "f" {
                    unit = String(unit.dropLast())
                    unit += "ves"
                }
                else {
                    unit += "s"
                }
            }
            
            portion += ingredient.num == nil && ingredient.denom == nil ? "": " "
            
            return portion + unit
        }

        return portion
    }
}
