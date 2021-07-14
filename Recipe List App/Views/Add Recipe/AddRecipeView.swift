//
//  AddRecipeView.swift
//  Recipe List App
//
//  Created by Lucas Van Tilburg on 14/7/21.
//

import SwiftUI

struct AddRecipeView: View {
    
    //properties for recipe metadata
    @State private var name = ""
    @State private var summary = ""
    @State private var prepTime = ""
    @State private var cookTime = ""
    @State private var totalTime = ""
    @State private var servings = ""
    
    //list type recipe metadata
    @State private var highlights = [String]()
    @State private var directions = [String]()
    
    
    var body: some View {
        
        VStack {
            //Hstack with form controls
            HStack {
                Button("Clear") {
                    //clear the form
                    
                }
                
                Spacer()
                
                Button("Add") {
                    //save recipe to core data
                    
                    //clear the form
                }

            }
        
            //scroll view with entry form
            ScrollView(showsIndicators: false) {
                
                VStack {
                    //recipe metadata
                    
                    AddMetaData(name: $name,
                                summary: $summary,
                                prepTime: $prepTime,
                                cookTime: $cookTime,
                                totalTime: $totalTime,
                                servings: $servings)
                    
                    //list data
                    AddListData(list: $highlights, title: "Highlights", placeHolderText: "Vegetarian")
                    AddListData(list: $directions, title: "Directions", placeHolderText: "Add the oil to the pan")
                }
            }
        }
        .padding(.horizontal)
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
