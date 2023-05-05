//
//  AsyncEditImageLoader.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/30/23.
//

import SwiftUI

struct AsyncEditImageLoader<Placeholder: View>: View {
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
                if loader.image!.size.width >= loader.image!.size.height {
                    image(loader.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .cornerRadius(6)
                        .overlay(
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .strokeBorder(Color.yellow100, lineWidth: 1)
                                
                                Path() { path in
                                    path.move(to: CGPoint(x: geometry.size.width / 3, y: 0))
                                    path.addLine(to: CGPoint(x: geometry.size.width / 3, y: geometry.size.height))
                                }
                                .stroke(Color.surface2, lineWidth: 1)
                                
                                Path() { path in
                                    path.move(to: CGPoint(x: geometry.size.width * 2 / 3, y: 0))
                                    path.addLine(to: CGPoint(x: geometry.size.width * 2 / 3, y: geometry.size.height))
                                }
                                .stroke(Color.surface2, lineWidth: 1)
                                
                                Path() { path in
                                    path.move(to: CGPoint(x: 0, y: geometry.size.height / 3))
                                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height / 3))
                                }
                                .stroke(Color.surface2, lineWidth: 1)
                                
                                Path() { path in
                                    path.move(to: CGPoint(x: 0, y: geometry.size.height * 2 / 3))
                                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height * 2 / 3))
                                }
                                .stroke(Color.surface2, lineWidth: 1)
                            }
                            
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
}

