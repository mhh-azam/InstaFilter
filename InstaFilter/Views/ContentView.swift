//
//  ContentView.swift
//  InstaFilter
//
//  Created by QBUser on 08/07/22.
//

import SwiftUI

struct ContentView: View {

    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showImagepicker = false
    @State private var filterIntensity = 0.0

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
                }

                HStack {
                    Button("Change Filter") {
                        //TODO: change filter
                    }

                    Spacer()

                    Button("Save") {
                        //TODO: save selected image
                    }
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
        image = Image(uiImage: inputImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
