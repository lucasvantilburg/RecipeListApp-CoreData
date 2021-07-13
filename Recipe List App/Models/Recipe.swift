//
//  Recipe.swift
//  Recipe List App
//
//  Created by Lucas Van Tilburg on 27/1/21.
//

import Foundation

class RecipeJSON: Identifiable, Decodable {
    
    var id:UUID?
    var name:String
    var featured:Bool
    var image:String
    var description:String
    var prepTime:String
    var cookTime:String
    
    //added
    var totalTime:String
    
    var servings:Int
    var highlights:[String]
    var ingredients:[IngredientJSON]
    var directions:[String]
    
}



