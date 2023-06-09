//
//  LifePhotoEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/14/23.
//

import SwiftUI

struct LifePhotoEditSheet: View, KeyboardReadable {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var vm: ProfileViewModel

    @State private var selectedTag: Int = 2
    
    @State var uiImage: UIImage = UIImage()
    
    @State var newUIImage: UIImage = UIImage()
    
    @State var croppedCGImage: CGImage?
    
    @State var text: String = ""
    
    @State private var isSatisfied: Bool = false

    @State private var isLoading: Bool = false
    
    @State private var bottomPadding: CGFloat = 0
    
    @State private var isKeyboardShowUp: Bool = false
    
    @State private var currentOffset: CGSize = .zero

    let textLengthLimit: Int = 200

    var body: some View {
        Sheet(
            size: [.large],
            header: {},
            content: {
                ScrollViewReader { scroll in
                    ScrollView {
                        VStack(spacing: 16) {
                            VStack {}
                                .frame(height: 342)
                                .background(
                                    AsyncImage(
                                        url: URL(string: vm.selectedLifePhoto?.contentUrl ?? ""),
                                        transaction: Transaction(animation: .easeInOut)
                                    ) { phase in
                                        switch phase {
                                        case .empty:
                                            if vm.selectedImage == nil {
                                                EmptyView()
                                            } else {
                                                GeometryReader { geometry  in
                                                    Image(uiImage: vm.selectedImage!)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(
                                                            width: imageWidth(tag: selectedTag),
                                                            height: imageHeight(tag: selectedTag)
                                                        )
                                                        .scaleEffect(vm.imageScale)
                                                        .cornerRadius(6)
                                                        .gesture(
                                                            DragGesture()
                                                                .onChanged { gesture in
                                                                    currentOffset = gesture.translation
                                                                }
                                                                .onEnded { _ in
                                                                    if vm.imageOffset.width < geometry.size.width {
                                                                        vm.imageOffset = CGSize(width: vm.imageOffset.width + self.currentOffset.width, height: vm.imageOffset.height + self.currentOffset.height)
                                                                        currentOffset = .zero
                                                                    } else {
                                                                        vm.imageOffset = .zero
                                                                    }
                                                                }
                                                        )
                                                        .gesture(
                                                            MagnificationGesture().onChanged({ val in
                                                                vm.imageScale = val
                                                            }).onEnded({ val in
                                                                vm.imageScale = val < 1 ? 1 : val
                                                            })
                                                        )
                                                        .overlay(
                                                            ZStack {
                                                                RoundedRectangle(cornerRadius: 6)
                                                                    .strokeBorder(Color.yellow100, lineWidth: 1)
                                                                
                                                                Path { path in
                                                                    path.move(
                                                                        to: CGPoint(
                                                                            x: geometry.size.width / 3,
                                                                            y: 0
                                                                        )
                                                                    )
                                                                    path.addLine(
                                                                        to: CGPoint(
                                                                            x: geometry.size.width / 3,
                                                                            y: geometry.size.height
                                                                        )
                                                                    )
                                                                }
                                                                .stroke(Color.surface2, lineWidth: 1)
                                                                
                                                                Path { path in
                                                                    path.move(
                                                                        to: CGPoint(
                                                                            x: geometry.size.width * 2 / 3,
                                                                            y: 0
                                                                        )
                                                                    )
                                                                    path.addLine(
                                                                        to: CGPoint(
                                                                            x: geometry.size.width * 2 / 3,
                                                                            y: geometry.size.height
                                                                        )
                                                                    )
                                                                }
                                                                .stroke(Color.surface2, lineWidth: 1)
                                                                
                                                                Path { path in
                                                                    path.move(
                                                                        to: CGPoint(
                                                                            x: 0,
                                                                            y: geometry.size.height / 3
                                                                        )
                                                                    )
                                                                    path.addLine(
                                                                        to: CGPoint(
                                                                            x: geometry.size.width,
                                                                            y: geometry.size.height / 3
                                                                        )
                                                                    )
                                                                }
                                                                .stroke(Color.surface2, lineWidth: 1)
                                                                
                                                                Path { path in
                                                                    path.move(
                                                                        to: CGPoint(
                                                                            x: 0,
                                                                            y: geometry.size.height * 2 / 3
                                                                        )
                                                                    )
                                                                    path.addLine(
                                                                        to: CGPoint(
                                                                            x: geometry.size.width,
                                                                            y: geometry.size.height * 2 / 3
                                                                        )
                                                                    )
                                                                }
                                                                .stroke(Color.surface2, lineWidth: 1)
                                                            }
                                                        )
                                                }
                                            }
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(
                                                    width: imageWidth(tag: selectedTag),
                                                    height: imageHeight(tag: selectedTag)
                                                )
                                                .scaleEffect(vm.imageScale)
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
                                                        vm.imageScale = value
                                                    }).onEnded({(value) in
                                                        vm.imageScale = value < 1 ? 1 : value
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
                                ).id(2)
                            
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
                            .onReceive(keyboardPublisher) { val in
                                isKeyboardShowUp = val
                                withAnimation {
                                    scroll.scrollTo(
                                        isKeyboardShowUp ? 1 : 2,
                                        anchor: .top
                                    )
                                }
                            }
                            
                            Spacer().id(1)
                        }
                    }
                    .scrollDisabled(true)
                }
            },
            footer: {
                isKeyboardShowUp
                ? nil
                : PrimaryButton(
                    label: "Save",
                    isTappable: $isSatisfied,
                    isLoading: $isLoading
                )
                .padding(.bottom, 16)
            }
        )
    }
    
    private func imageHeight(
        tag: Int
    ) -> (CGFloat) {
        switch tag {
        case 0:
            return (UIScreen.main.bounds.width - 48)/16 * 9
        case 1:
            return UIScreen.main.bounds.width - 48
        case 2:
            return (UIScreen.main.bounds.width - 48)/4 * 3
        case 3:
            return UIScreen.main.bounds.width - 48
        default:
            return UIScreen.main.bounds.width - 48
        }
    }
    
    private func imageWidth(
        tag: Int
    ) -> (CGFloat) {
        switch tag {
        case 0:
            return UIScreen.main.bounds.width - 48
        case 1:
            return (UIScreen.main.bounds.width - 48)/16 * 9
        case 2:
            return UIScreen.main.bounds.width - 48
        case 3:
            return (UIScreen.main.bounds.width - 48)/4 * 3
        default:
            return (UIScreen.main.bounds.width - 48)/16 * 9
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
