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
    
    static func getPortion(ingredient:Ingredient, recipeServings:Int, targetServings:Int) -> String {
        
        var portion = ""
        var numerator = ingredient.num ?? 1
        var denominator = ingredient.denom ?? 1
        var wholeParts = 0
        
        if (ingredient.num != nil) {
            
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
