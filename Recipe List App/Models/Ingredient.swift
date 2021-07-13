//
//  Ingredient.swift
//  Recipe List App
//
//  Created by Lucas Van Tilburg on 23/6/21.
//

import Foundation

class IngredientJSON: Identifiable, Decodable {
    
    var id:UUID?
    var name:String
    var num:Int?
    var denom:Int?
    var unit:String?
}
