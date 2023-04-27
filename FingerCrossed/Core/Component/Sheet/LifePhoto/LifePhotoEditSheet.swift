//
//  LifePhotoEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/14/23.
//

import SwiftUI

struct LifePhotoEditSheet: View {
    @Environment(\.presentationMode) private var presentationMode

    @State private var selectedTag: Int?
    @ObservedObject var config: LifePhotoViewModel

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
                    .frame(width: 342, height: 342)
                    .background(
                        AsyncImage(
                            url: URL(string: config.selectedLifePhoto?.photoUrl ?? ""),
                            transaction: Transaction(animation: .easeInOut)
                        ) { phase in
                            switch phase {
                            case .empty:
                                EmptyView() // TODO(Sam): Replace with shimmer later
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .scaleEffect(config.imageScale)
                                    .gesture(
                                        MagnificationGesture().onChanged({(value) in
                                            config.imageScale = value
                                        }).onEnded({(value) in
                                            config.imageScale = value < 1 ? 1 : value
                                        })
                                    )
                            case .failure:
                                ProgressView() // TODO(Sam): Replace with shimmer later
                            @unknown default:
                                EmptyView()
                            }
                        }
                    )
                    .clipped()
                    
                    HStack(spacing: 12) {
                        TagButton(label: "16:9", tag: .constant(0), isSelected: $selectedTag)
                        TagButton(label: "9:16", tag: .constant(1), isSelected: $selectedTag)
                        TagButton(label: "4:3", tag: .constant(2), isSelected: $selectedTag)
                        TagButton(label: "3:4", tag: .constant(3), isSelected: $selectedTag)
                    }
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    
                    VStack(alignment: .trailing,spacing: 6) {
                        CaptionInputBar(hint: "Add caption", defaultPresentLine: 6, lineLimit: 6)

                        Text("0/200")
                            .fontTemplate(.captionRegular)
                            .foregroundColor(Color.textHelper)
                        
                    }
                    .padding(.horizontal, 1) // offset border width
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.16)) {
                            proxy.scrollTo(1, anchor: .center)
                        }
                    }
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }
                    .buttonStyle(PrimaryButton())
                    .padding(.vertical, 4) // 20 - 16
                    .padding(.bottom, 30)
                    .id(1)
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
}

struct LifePhotoEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoEditSheet(config: LifePhotoViewModel())
    }
}
