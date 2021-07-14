//
//  AddListData.swift
//  Recipe List App
//
//  Created by Lucas Van Tilburg on 14/7/21.
//

import SwiftUI

struct AddListData: View {
    
    @Binding var list:[String]
    
    var title: String
    var placeHolderText: String
    @State private var item = ""
    
    var body: some View {
        
        VStack (alignment: .leading) {
            HStack {
                Text("\(title): ")
                    .bold()
                
                TextField(placeHolderText, text: $item)
                
                Button("Add") {
                    //add item to the list
                    if item.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                        //add item to list
                        list.append(item.trimmingCharacters(in: .whitespacesAndNewlines))
                        
                        //clear text field
                        item = ""
                    }
                }
            }
            
            //List out the items added so far
            ForEach(list, id: \.self) { text in
                HStack {
                    Image(systemName: "circlebadge.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height:5)
                    Text(text)
                }
                .foregroundColor(.black)
                
            }
            .padding([.leading, .bottom])
        } 
    }
}
