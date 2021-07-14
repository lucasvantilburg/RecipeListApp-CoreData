//
//  ImagePicker.swift
//  Recipe List App
//
//  Created by Lucas Van Tilburg on 14/7/21.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable  {
    
    @Environment(\.presentationMode) var presentationMode
    
    var selectedSource: UIImagePickerController.SourceType
    
    @Binding var recipeImage:UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        //create the image picker controller
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        
        //check that this source is available first
        if UIImagePickerController.isSourceTypeAvailable(selectedSource) {
            imagePickerController.sourceType = selectedSource
        }
        
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        //create a new coordinator
        
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        var parent:ImagePicker
        
        init(parent:ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            //check if we can get the image
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                
                //we were able to get the ui image into the image constant
                //pass this back to AddRecipeView
                parent.recipeImage = image
            }
            
            //dismiss this view
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
