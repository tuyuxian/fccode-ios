//
//  AsyncImageLoader.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/18/23.
//

import SwiftUI

struct AsyncImageLoader<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder
    private let url: URL
    private let image: (UIImage) -> Image
        
        init(
            url: URL,
            @ViewBuilder placeholder: () -> Placeholder,
            @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
        ) {
            self.url = url
            self.placeholder = placeholder()
            self.image = image
            _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
        }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        GeometryReader { geometry in
            if loader.image != nil {
                
//                Image(uiImage: loader.image!)
//                    .resizable()
                
//                if imageIsLandscape(url: self.url) {
                if loader.image!.size.width >= loader.image!.size.height {
                    image(loader.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .ignoresSafeArea()
                        .background(
                            image(loader.image!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                                .blur(radius: 10)
                                .overlay(
                                    Color.black.opacity(0.4)
                                )
                        )
                }else {
                    image(loader.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .ignoresSafeArea(.all)
                }

            } else {
                placeholder
            }
        }
    }
    
    func imageIsLandscape(url: URL) -> Bool {
        if let imageSource = CGImageSourceCreateWithURL(url as CFURL, nil) {
            if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary? {
                let pixelWidth = imageProperties[kCGImagePropertyPixelWidth] as! Int
                let pixelHeight = imageProperties[kCGImagePropertyPixelHeight] as! Int
                
                return pixelWidth >= pixelHeight ? true : false
                //return "Width: \(pixelWidth), Height: \(pixelHeight)"
            }
        }
        return false
    }
}