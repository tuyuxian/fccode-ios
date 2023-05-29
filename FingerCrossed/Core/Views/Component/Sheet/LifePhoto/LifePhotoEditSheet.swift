//
//  LifePhotoEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/14/23.
//

import SwiftUI

struct LifePhotoEditSheet: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var vm: ProfileViewModel

    @State private var selectedTag: Int = 2
    @State var uiImage: UIImage = UIImage()
    
    @State var newUIImage: UIImage = UIImage()
    @State var croppedCGImage: CGImage?
    
    @State var text: String = ""
    
    @State private var isSatisfied: Bool = false
    /// Flag for loading state
    @State private var isLoading: Bool = false
    
    @State private var bottomPadding: CGFloat = 0
    
    let textLengthLimit: Int = 200

    var body: some View {
                VStack(spacing: 16) {
//                    Image(uiImage: config.newUIImage)
//
//                    Image(uiImage: UIImage(cgImage: config.cropCGImage))
                    
                    Text("Nice Picture!")
                        .fontTemplate(.h2Medium)
                        .foregroundColor(Color.text)
                        .frame(height: 34)
                        .multilineTextAlignment(.center)
                        .padding(.top, 30)
                        .id(2)
                        VStack {}
                            .frame(height: 342)
                        //                    .background(
                        //                        AsyncEditImageLoader(
                        //                            url: URL(string: vm.selectedLifePhoto?.contentUrl ?? "")!,
                        //                            config: vm,
                        //                            placeholder: {
                        //                        // AsyncImage(
                        //                        //     url: URL(string: vm.selectedLifePhoto?.photoUrl ?? ""),
                        //                        //     transaction: Transaction(animation: .easeInOut)
                        //                        // ) { phase in
                        //                        //     switch phase {
                        //                        //     case .empty:
                        //                        //         if vm.selectedImage == nil {
                        //                        //             EmptyView()
                        //                        //         } else {
                        //                        //             Image(uiImage: vm.selectedImage!)
                        //                        //                 .resizable()
                        //                        //                 .aspectRatio(contentMode: .fill)
                        //                        //                 .frame(
                        //                        //                     width: imageWidth(tag: selectedTag),
                        //                        //                     height: imageHeight(tag: selectedTag)
                        //                        //                 )
                        //                        //                 .scaleEffect(vm.imageScale)
                        //                        //                 .cornerRadius(6)
                        //                        //                 .background(
                        //                        //                     RoundedRectangle(cornerRadius: 6)
                        //                        //                         .strokeBorder(Color.yellow100, lineWidth: 1)
                        //                        //                 )
                        //                        //                 .onChange(of: uiImage, perform: { newImage in
                        //                        //                     newUIImage = UIImage(
                        //                        //                         data: newImage.jpegData(compressionQuality: 0.95)!)!
                        //                        //                 })
                        //                        //                 .gesture(
                        //                        //                     MagnificationGesture().onChanged({(value) in
                        //                        //                         vm.imageScale = value
                        //                        //                     }).onEnded({(value) in
                        //                        //                         vm.imageScale = value < 1 ? 1 : value
                        //                        //                     })
                        //                        //                 )
                        //                        //         }
                        //                        //     case .success(let image):
                        //                        //         image
                        //                        //             .resizable()
                        //                        //             .aspectRatio(contentMode: .fill)
                        //                        //             .frame(
                        //                        //                 width: imageWidth(tag: selectedTag),
                        //                        //                 height: imageHeight(tag: selectedTag)
                        //                        //             )
                        //                        //             .scaleEffect(vm.imageScale)
                        //                        //             .cornerRadius(6)
                        //                        //             .background(
                        //                        //                 RoundedRectangle(cornerRadius: 6)
                        //                        //                     .strokeBorder(Color.yellow100, lineWidth: 1)
                        //                        //             )
                        //                        //             .onChange(of: uiImage, perform: { newImage in
                        //                        //                 newUIImage = UIImage(
                        //                        //                     data: newImage.jpegData(compressionQuality: 0.95)!)!
                        //                        //             })
                        //                        //             .gesture(
                        //                        //                 MagnificationGesture().onChanged({(value) in
                        //                        //                     vm.imageScale = value
                        //                        //                 }).onEnded({(value) in
                        //                        //                     vm.imageScale = value < 1 ? 1 : value
                        //                        //                 })
                        //                        //             )
                        //                        //     case .failure:
                        //                                Shimmer(
                        //                                    size: CGSize(
                        //                                        width: UIScreen.main.bounds.size.width - 48,
                        //                                        height: 342
                        //                                    )
                        //                                )
                        //                            },
                        //                            image: { Image(uiImage: $0)})
                        //                            .frame(
                        //                                width: imageWidth(tag: selectedTag),
                        //                                height: imageHeight(tag: selectedTag)
                        //                            )
                        //
                        ////                        AsyncImage(
                        ////                            url: URL(string: config.selectedLifePhoto?.photoUrl ?? ""),
                        ////                            transaction: Transaction(animation: .easeInOut)
                        ////                        ) { phase in
                        ////                            switch phase {
                        ////                            case .empty:
                        ////                                EmptyView()
                        ////                            case .success(let image):
                        ////                                image
                        ////                                    .resizable()
                        ////                                    .aspectRatio(contentMode: .fill)
                        ////                                    .frame(
                        ////                                        width: imageWidth(tag: selectedTag),
                        ////                                        height: imageHeight(tag: selectedTag)
                        ////                                    )
                        ////                                    .scaleEffect(config.imageScale)
                        ////                                    .cornerRadius(6)
                        ////                                    .background(
                        ////                                        RoundedRectangle(cornerRadius: 6)
                        ////                                            .strokeBorder(Color.yellow100, lineWidth: 1)
                        ////                                    )
                        ////                                    .onChange(of: uiImage, perform: { newImage in
                        ////                                        newUIImage = UIImage(
                        ////                                            data: newImage.jpegData(compressionQuality: 0.95)!)!
                        ////                                    })
                        ////                                    .gesture(
                        ////                                        MagnificationGesture().onChanged({(value) in
                        ////                                            config.imageScale = value
                        ////                                        }).onEnded({(value) in
                        ////                                            config.imageScale = value < 1 ? 1 : value
                        ////                                        })
                        ////                                    )
                        ////                            case .failure:
                        ////                                Shimmer(
                        ////                                    size: CGSize(
                        ////                                        width: UIScreen.main.bounds.size.width - 48,
                        ////                                        height: 342
                        ////                                    )
                        ////                                )
                        ////                            @unknown default:
                        ////                                EmptyView()
                        ////                            }
                        ////                        }
                        //                    )
                        //                    .clipped()
                        
                    HStack(spacing: 12) {
                        TagButton(label: "16:9", tag: .constant(0), isSelected: $selectedTag)
                        TagButton(label: "9:16", tag: .constant(1), isSelected: $selectedTag)
                        TagButton(label: "4:3", tag: .constant(2), isSelected: $selectedTag)
                        TagButton(label: "3:4", tag: .constant(3), isSelected: $selectedTag)
                    }
                    
                    CaptionInputBar(
                        text: $text,
                        hint: "Write a caption...",
                        defaultPresentLine: 6,
                        lineLimit: 6,
                        textLengthLimit: textLengthLimit
                    )
                    .onChange(of: text) { _ in
                        isSatisfied = true
                    }

                    Spacer()
                    
                    PrimaryButton(
                        label: "Save",
                        isTappable: $isSatisfied,
                        isLoading: $isLoading
                    )
                    .padding(.bottom, 16)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: bottomPadding, trailing: 0))
                    .onReceive(NotificationCenter.default.publisher(for: UIWindow.keyboardWillShowNotification),
                               perform: updateFrame)
                    .onReceive(NotificationCenter.default.publisher(for: UIWindow.keyboardWillHideNotification),
                               perform: updateFrame)
                }
            .padding(.horizontal, 24)
            .background(Color.white)
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
            .scrollDismissesKeyboard(.immediately)
    }
    
    private func updateFrame(_ notification: Notification) {
            let nsValue = (notification.userInfo?[UIWindow.keyboardFrameEndUserInfoKey] as? NSValue)
            let keyboardHeight = nsValue?.cgRectValue.height ?? 0
        if notification.name == UIWindow.keyboardWillShowNotification {
                bottomPadding = keyboardHeight - 16
            } else {
                bottomPadding = 0
            }
        }
    
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
        LifePhotoEditSheet(
            vm: ProfileViewModel()
        )
    }
}
