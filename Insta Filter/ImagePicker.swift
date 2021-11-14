//
//  ImagePicker.swift
//  Insta Filter
//
//  Created by Yash Poojary on 10/11/21.
//

import SwiftUI


struct ImagePicker: UIViewControllerRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImg = info[.originalImage] as? UIImage {
                parent.image = uiImg
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
    
    @Binding var image: UIImage?
    @Environment (\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    
    
}







































//
//struct ImagePicker: UIViewControllerRepresentable {
//
//
//    //delegates are objects which respond to events which occur elsewhere; Delegate are added to textfield, it's notified when there's any change, they
//    // are able to change stuff without having to create a custom text field of their own
//
//
//    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//        var parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let uiImage = info[.originalImage] as? UIImage {
//                parent.image = uiImage
//            }
//
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//
//    }
//
//    @Binding var image: UIImage?
//    @Environment(\.presentationMode) var presentationMode
//
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//
//
//
//
//
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//
//        // so that whenever a user selects an image, it will report that action to coordinator.
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//
//    }
//
//}
