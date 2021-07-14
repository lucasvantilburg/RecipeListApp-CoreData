//
//  SearchBarView.swift
//  Recipe List App
//
//  Created by Lucas Van Tilburg on 14/7/21.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var filterBy:String
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(5)
                .shadow(radius: 4)
            
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("Filter by...", text: $filterBy)
                
                Button {
                    //clear the text field
                    filterBy = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                }

            }
            .padding()
        }
        .frame(height: 48)
        .foregroundColor(.gray)
    }
}

