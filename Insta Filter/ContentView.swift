//
//  ContentView.swift
//  Insta Filter
//
//  Created by Yash Poojary on 03/11/21.
//

import SwiftUI



struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    
    
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}






















//struct ContentView: View {
//    @State private var image: Image?
//
//
//    var body: some View {
//        VStack {
//            image?
//                .resizable()
//                .scaledToFit()
//        }
//        .onAppear(perform: loadData)
//    }
//
//
//    func loadData() {
//        guard let inputImage = UIImage(named: "Example") else {
//            return
//        }
//
//        let beginImage = CIImage(image: inputImage)
//
//        let context = CIContext()
//
//
//        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else {
//            return
//        }
//
//        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//        currentFilter.setValue(1000, forKey: kCIInputRadiusKey)
//        currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)
//
//
//
//        guard let outputImage = currentFilter.outputImage else {
//            return
//        }
//
//        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
//            let uiimage = UIImage(cgImage: cgImage)
//
//            image = Image(uiImage: uiimage)
//        }
//
//    }
//}

//struct ContentView: View {
//
//    @State private var showActionSheet = false
//    @State private var backgroundColor = Color.white
//
//    var body: some View {
//        Text("Hello World!")
//            .frame(width: 300, height: 300)
//            .background(backgroundColor)
//            .onTapGesture {
//                showActionSheet = true
//            }
//            .confirmationDialog(Text("Change Background"), isPresented: $showActionSheet, titleVisibility: .visible) {
//                Button("Change Color to red") { backgroundColor = .red  }
//                Button("Change Color to orange") { backgroundColor = .orange }
//                Button("Delete", role: .destructive) {}
//                Button("Cancel", role: .cancel) {}
//
//            }
//
//
//    }
//}



//
//struct ContentView: View {
//
//    @State private var blurAmount: CGFloat = 0 {
//        didSet {
//            print("The current value is \(blurAmount)")
//        }
//    }
//
//    var body: some View {
//        let blur = Binding<CGFloat>(
//            get: {
//                blurAmount
//            }, set: {
//                blurAmount = $0
//            }
//        )
//
//
//        VStack {
//            Text("Hello World!")
//                .blur(radius: blurAmount)
//
//            Slider(value: blur, in: 0...10)
//                .padding()
//
//        }
//
//    }
//}
