//
//  ContentView.swift
//  Insta Filter
//
//  Created by Yash Poojary on 03/11/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins



struct ContentView: View {
    @State private var image: Image?
    @State private var intensity = 0.5
    @State private var isShowingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false
    @State private var processedImage: UIImage?
    @State private var isShowingAlert = false
    @State private var currentFilterName = "Sepia Tone"
    @State private var isViewEmpty = false
    @State private var secondFilter = 0.5
    
    
    
    
    let context = CIContext()

    
    
    
    
    var body: some View {
        
        let filterIntensity = Binding<Double>(
            get: {
                intensity
            }, set: {
                intensity = $0
                applyProcessing()
            }
        )
        
        let secondFilterIntensity = Binding<Double>(
            get: {
                secondFilter
            }, set: {
                secondFilter = $0
                applyProcessing()
            }
        )
        
        
        
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                        if image != nil {
                            image?
                                .resizable()
                                .scaledToFit()
                        } else {
                            Text("Tap to select an image")
                                .foregroundColor(Color.white)
                                .font(.headline)
                        }
                        
                }
                .onTapGesture {
                    isShowingImagePicker = true
                }
                
                VStack {
                HStack {
                    Text("Intensity")
                        Slider(value: filterIntensity)
                }
                    HStack {
                    Text("Radius")
                        Slider(value: secondFilterIntensity)
                   }
                }

                .padding()
                
                HStack {
                    Button(currentFilterName) {
                       showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        
                        
                        if image != nil {
                            
                            guard let processedImage = processedImage else {
                                    return
                                }
                        
        
                                
                                let imageSaver = ImageSaver()
                                
                                imageSaver.successHandler = {
                                    print("Success")
                                }
                                
                                imageSaver.errorHandler = {
                                    print("Oops \($0.localizedDescription)")
                                }
                                
                                imageSaver.writeToPhotoAlbum(image: processedImage)
                            
                        } else {
                            isShowingAlert = true
                        }
            
                       
                        

                    }
                }
                
            }
            .padding([.horizontal, .vertical])
            .navigationBarTitle("InstaFilter")
            .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
            
            .alert("Please select an image", isPresented: $isShowingAlert, actions: {
                Button("Okay") {}
            }, message: {
                Text("We couldn't find an image!")
            })
            
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text("Please select an image"), message: Text("We couldn't find an image!"), dismissButton: .default(Text("Okay")))
            }
        
         
        
            
            .confirmationDialog("Choose a filter", isPresented: $showingFilterSheet) {
                Button("Crystallise") {
                    setFilter(CIFilter.crystallize())
                    currentFilterName = "Crystallize"
                }
                
                Button("Gaussian Blur") {
                    setFilter(CIFilter.gaussianBlur())
                    currentFilterName = "Gaussian Blur"
                }
                
                Button("Sepia Tone") {
                    setFilter(CIFilter.sepiaTone())
                    currentFilterName = "Sepia Tone"
                }
            }
           
    
            
        }
        
        
    }
    
    func loadImage() {
        
        guard let inputImage = inputImage else {
            return
        }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(secondFilter * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(intensity * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else {
            return
        }
        
        if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImg = UIImage(cgImage: cgImg)
            
            image = Image(uiImage: uiImg)
            
            processedImage = uiImg
        
            
        }
        
        
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        
        
        loadImage()
    }
}


//
//public extension String {
//
//    var strippedExtra: String {
//        //
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//class ImageSaver: NSObject {
//    func writeToPhotoAlbum(image: UIImage) {
//        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
//    }
//
//    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//        print("save finished")
//    }
//}
//
//struct ContentView: View {
//    @State private var isShowing = false
//    @State private var image: Image?
//    @State private var inputImage: UIImage?
//
//
//
//    var body: some View {
//        VStack {
//            image?
//                .resizable()
//                .scaledToFit()
//
//            Button("Select an Image") {
//                isShowing = true
//            }
//        }
//        .sheet(isPresented: $isShowing, onDismiss: loadImage) {
//            ImagePicker(inputImage: $inputImage)
//        }
//
//    }
//
//    func loadImage() {
//        guard let inputImage = inputImage else {
//            return
//        }
//        image = Image(uiImage: inputImage)
//
//        let imageSaver = ImageSaver()
//        imageSaver.writeToPhotoAlbum(image: inputImage)
//
//
//
//
//
//    }
//}























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
