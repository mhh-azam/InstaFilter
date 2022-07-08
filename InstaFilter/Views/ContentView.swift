//
//  ContentView.swift
//  InstaFilter
//
//  Created by QBUser on 08/07/22.
//

import SwiftUI

struct ContentView: View {

    @State private var image: Image?
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
                    //TODO: Show imagepicker to select image
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

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
