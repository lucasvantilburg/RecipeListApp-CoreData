//
//  RecipeFeaturedView.swift
//  Recipe List App
//
//  Created by Lucas Van Tilburg on 14/2/21.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @State var isDetailViewShowing = false
    @State var tabSelectionIndex = 0
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)], predicate:
                    NSPredicate(format: "featured == true")) var recipes:FetchedResults<Recipe>
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 0) {
            
            Text("Featured Recipes")
                .bold()
                .padding(.leading)
                .padding(.top, 40)
                .font(Font.custom("Avenir Heavy", size: 26))
            
            GeometryReader { geo in
                
                TabView (selection: $tabSelectionIndex) {
                    
                    //Loop through each recipe
                    ForEach(0..<recipes.count) { index in
                        
                        
                        
                        //Recipe Card Button
                        Button(action: {
                            
                            //show recipe detail sheet
                            self.isDetailViewShowing = true
                            
                        }, label: {
                            //Recipe Card
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                
                                
                                VStack (spacing:0) {
                                    let image = UIImage(data: recipes[index].image ?? Data()) ?? UIImage()
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                    Text(recipes[index].name)
                                        .padding(5)
                                        .font(Font.custom("Avenir", size: 16))
                                }
                            }
                        })
                        .tag(index)
                        .sheet(isPresented: $isDetailViewShowing, content: {
                            RecipeDetailView(recipe: recipes[index])
                        })
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: geo.size.width - 40, height: geo.size.height - 100, alignment: .center)
                        .cornerRadius(15)
                        .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5, y: 5)
                        
                        
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            
            VStack (alignment: .leading, spacing: 10) {
                Text("Preparation Time:")
                    .font(Font.custom("Avenir Heavy", size: 16))
                Text(recipes[tabSelectionIndex].prepTime)
                    .font(Font.custom("Avenir", size: 15))
                
                Text("Highlights")
                    .font(Font.custom("Avenir Heavy", size: 16))
                RecipeHighlights(highlights: recipes[tabSelectionIndex].highlights)
            }
            .padding([.leading, .bottom])
            
        }
        .onAppear(perform: {
            setFeaturedIndex()
        })
        
        
        
    }
    
    func setFeaturedIndex() {
        let index = recipes.firstIndex { (recipe) -> Bool
            in return recipe.featured
        }
        tabSelectionIndex = index ?? 0
    }
}
