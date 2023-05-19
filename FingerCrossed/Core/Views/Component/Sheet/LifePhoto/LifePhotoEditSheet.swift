//
//  LifePhotoEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/14/23.
//

import SwiftUI

struct LifePhotoEditSheet: View {
    @Environment(\.presentationMode) private var presentationMode

    @State private var selectedTag: Int = 2
    @ObservedObject var config: LifePhotoViewModel
    @State var uiImage: UIImage = UIImage()
    @State var newUIImage: UIImage = UIImage()
    
    @State private var text: String = ""
    
    @State private var isStatisfied: Bool = false
    /// Flag for loading state
    @State private var isLoading: Bool = false
    let textLengthLimit: Int = 200

    var body: some View {
        ScrollViewReader { (proxy: ScrollViewProxy) in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    Text("Nice Picture!")
                        .fontTemplate(.h2Medium)
                        .foregroundColor(Color.text)
                        .frame(height: 34)
                        .multilineTextAlignment(.center)
                        .padding(.top, 30)
                        .id(2)
                    
                    VStack {
                    }
                    .frame(height: 342)
                    .background(
                        AsyncImage(
                            url: URL(string: config.selectedLifePhoto?.photoUrl ?? ""),
                            transaction: Transaction(animation: .easeInOut)
                        ) { phase in
                            switch phase {
                            case .empty:
                                EmptyView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(
                                        width: imageWidth(tag: selectedTag),
                                        height: imageHeight(tag: selectedTag)
                                    )
                                    .scaleEffect(config.imageScale)
                                    .cornerRadius(6)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6)
                                            .strokeBorder(Color.yellow100, lineWidth: 1)
                                    )
                                    .onChange(of: uiImage, perform: { newImage in
                                        newUIImage = UIImage(
                                            data: newImage.jpegData(compressionQuality: 0.95)!)!
                                    })
                                    .gesture(
                                        MagnificationGesture().onChanged({(value) in
                                            config.imageScale = value
                                        }).onEnded({(value) in
                                            config.imageScale = value < 1 ? 1 : value
                                        })
                                    )
                            case .failure:
                                Shimmer(
                                    size: CGSize(
                                        width: UIScreen.main.bounds.size.width - 48,
                                        height: 342
                                    )
                                )
                            @unknown default:
                                EmptyView()
                            }
                        }
                    )
//                    .clipped()
                    
                    HStack(spacing: 12) {
                        TagButton(label: "16:9", tag: .constant(0), isSelected: $selectedTag)
                        TagButton(label: "9:16", tag: .constant(1), isSelected: $selectedTag)
                        TagButton(label: "4:3", tag: .constant(2), isSelected: $selectedTag)
                        TagButton(label: "3:4", tag: .constant(3), isSelected: $selectedTag)
                    }
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    
                    CaptionInputBar(
                        text: $text,
                        hint: "Type your self introduction",
                        defaultPresentLine: 10,
                        lineLimit: 10,
                        textLengthLimit: textLengthLimit
                    )
                    .onChange(of: text) { _ in
                        isStatisfied = true
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.16)) {
                            proxy.scrollTo(1, anchor: .center)
                        }
                    }
                    
                    PrimaryButton(
                        label: "Save",
                        isTappable: $isStatisfied,
                        isLoading: $isLoading
                    )
                }
            }
            .padding(.horizontal, 24)
            .background(Color.white)
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
            .scrollDismissesKeyboard(.immediately)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.16)) {
                    UIApplication.shared.closeKeyboard()
                    proxy.scrollTo(2, anchor: .top)
                }
            }
        }

    }
    
//    func getImageData(url: String) -> Data {
//        var loader: ImageLoader
//        var image: UIImage
//
//        loader = ImageLoader(url: URL(string: url)!)
//        if loader.image != nil {
//            image = loader.image!
//            return image.jpegData(compressionQuality: 0.95)!
//        }
//        return Data()
//    }
    
    func imageHeight(tag: Int) -> (CGFloat) {
        switch tag {
        case 0:
            return 192.375
            
        case 1:
            return 342
            
        case 2:
            return 256
            
        case 3:
            return 342
            
        default:
            return 256
        }
    }
    
    func imageWidth(tag: Int) -> (CGFloat) {
        switch tag {
        case 0:
            return 342
            
        case 1:
            return 192.375
            
        case 2:
            return 342
            
        case 3:
            return 256
            
        default:
            return 342
        }
    }
}

struct LifePhotoEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoEditSheet(config: LifePhotoViewModel())
    }
}
