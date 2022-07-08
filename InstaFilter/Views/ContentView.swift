//
//  ContentView.swift
//  InstaFilter
//
//  Created by QBUser on 08/07/22.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI


struct ContentView: View {

    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var showImagepicker = false
    @State private var filterIntensity = 0.0

    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.secondary)

                    Text("Tap to select an Image")
                        .font(.headline)
                        .foregroundColor(.white)

                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showImagepicker = true
                }

                HStack {
                    Text("Filter Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in
                            applyProcessing()
                        }
                }

                HStack {
                    Button("Change Filter") {
                        //TODO: change filter
                    }

                    Spacer()

                    Button("Save", action: save)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
            .sheet(isPresented: $showImagepicker) {
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { _ in
                loadImage()
            }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        let ciImage = CIImage(image: inputImage)
        currentFilter.setValue(ciImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    func applyProcessing() {
        currentFilter.intensity = Float(filterIntensity)
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }

    func save() {
        guard let processedImage = processedImage else { return }
        let imageSaver = ImageSaver()

        imageSaver.successHandler = {
            print("Success!")
        }

        imageSaver.errorHandler = {
            print("Oops: \($0.localizedDescription)")
        }

        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
