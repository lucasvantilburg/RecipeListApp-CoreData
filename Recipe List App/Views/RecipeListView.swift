//
//  ContentView.swift
//  Recipe List App
//
//  Created by Lucas Van Tilburg on 27/1/21.
//

import SwiftUI

struct RecipeListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var model:RecipeModel
    //@ObservedObject var model = RecipeModel()
    
    var body: some View {
        
        
        NavigationView {
            
            VStack (alignment: .leading) {
                
                Text("All Recipes")
                    .bold()
                    .padding(.top, 40)
                    .font(Font.custom("Avenir Heavy", size: 26))
                
                ScrollView {
                    LazyVStack (alignment: .leading) {
                        ForEach(model.recipes) { r in
                            
                            NavigationLink(
                                destination: RecipeDetailView(recipe:r),
                                label: {
                                    
                                    //MARK: Row Item
                                    HStack(spacing: 20.0) {
                                        let image = UIImage(data: r.image ?? Data()) ?? UIImage()
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50, alignment: .center)
                                            .clipped()
                                            .cornerRadius(5)
                                        
                                        VStack (alignment: .leading) {
                                            Text(r.name)
                                                .foregroundColor(.black)
                                                .font(Font.custom("Avenir Heavy", size: 16))
                                            
                                            RecipeHighlights(highlights: r.highlights)
                                                .foregroundColor(.black)
                                        }
                                    }
                                })
                            
                            
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .padding(.leading)
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipeModel())
    }
}
