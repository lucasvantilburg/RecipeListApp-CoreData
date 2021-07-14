//
//  AddRecipeView.swift
//  Recipe List App
//
//  Created by Lucas Van Tilburg on 14/7/21.
//

import SwiftUI

struct AddRecipeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var tabSelection:Int
    
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
    
    //ingredient data
    @State private var ingredients = [IngredientJSON]()
    
    //recipe image
    @State private var recipeImage:UIImage?
    
    //image picker
    @State private var isShowingImagePicker = false
    @State private var selectedImageSource = UIImagePickerController.SourceType.photoLibrary
    @State private var placeHolderImage = Image("noImageAvailable")
    
    var body: some View {
        
        VStack {
            //Hstack with form controls
            HStack {
                Button("Clear") {
                    //clear the form
                    clear()
                }
                
                Spacer()
                
                Button("Add") {
                    //save recipe to core data
                    addRecipe()
                    
                    //clear the form
                    clear()
                    
                    //navigate to the list
                    tabSelection = 1
                }

            }
        
            //scroll view with entry form
            ScrollView(showsIndicators: false) {
                
                VStack {
                    
                    //recipe image
                    placeHolderImage
                        .resizable()
                        .scaledToFit()
                    
                    HStack {
                        Button("Photo Library") {
                            selectedImageSource = .photoLibrary
                            isShowingImagePicker = true
                        }
                        
                        Text(" | ")
                        
                        Button("Camera") {
                            selectedImageSource = .camera
                            isShowingImagePicker = true
                        }
                    }
                    .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                        ImagePicker(selectedSource: selectedImageSource, recipeImage: $recipeImage)
                    }
                    
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
                    
                    //ingredient data
                    AddIngredientData(ingredients: $ingredients)
                }
            }
        }
        .padding([.horizontal, .bottom])
    }
    
    func loadImage() {
        //check if an image was selected from the library
        if recipeImage != nil {
            //set it as the placeholder image
            placeHolderImage = Image(uiImage: recipeImage!)
        }
    }
    
    func clear() {
        //clear all the fields
        
        name = ""
        summary = ""
        prepTime = ""
        cookTime = ""
        totalTime = ""
        servings = ""
        
        highlights = [String]()
        directions = [String]()
        
        ingredients = [IngredientJSON]()
        
        recipeImage = nil
        placeHolderImage = Image("noImageAvailable")
    }
    
    func addRecipe() {
        //add recipe into core data
        
        let recipe = Recipe(context: viewContext)
        
        recipe.id = UUID()
        recipe.name = name
        recipe.featured = false
        recipe.image = recipeImage?.pngData()
        recipe.summary = summary
        recipe.prepTime = prepTime
        recipe.cookTime = cookTime
        recipe.totalTime = totalTime
        recipe.servings = Int(servings) ?? 1
        recipe.highlights = highlights
        recipe.directions = directions
        
        //add ingredients
        for i in ingredients {
            let ingredient = Ingredient(context: viewContext)
            
            ingredient.id = UUID()
            ingredient.name = i.name
            ingredient.num = i.num ?? 1
            ingredient.denom = i.denom ?? 1
            ingredient.unit = i.unit
            
            recipe.addToIngredients(ingredient)
        }
        
        //save to core data
        do {
            try viewContext.save()
        }
        catch {
            //couldn't save recipe
        }
        
    }
}
