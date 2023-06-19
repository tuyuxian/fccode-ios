//
//  LifePhotoEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/14/23.
//

import SwiftUI

struct LifePhotoEditSheet: View, KeyboardReadable {
    /// View controller
    @Environment(\.dismiss) private var dismiss
    /// Observed basic info view model
    @ObservedObject var basicInfoVM: BasicInfoViewModel
    /// Init life photo edit sheet view model
    @StateObject private var vm = LifePhotoEditSheetViewModel()
        
    @State var text: String
    
    @FocusState private var focus: Bool

    var body: some View {
        Sheet(
            size: [.large],
            header: {
                Text("Nice Picture!")
                    .fontTemplate(.h2Medium)
                    .foregroundColor(Color.text)
                    .frame(height: 34)
                    .padding(.bottom, 16)
            },
            content: {
                ScrollViewReader { scroll in
                    ScrollView {
                        VStack(spacing: 16) {
                            if basicInfoVM.selectedImage != nil {
                                VStack {}
                                    .frame(width: UIScreen.main.bounds.width - 48, height: 342)
                                    .id(2)
                                    .background(
                                        EditableImage(
                                            basicInfoVM: basicInfoVM,
                                            vm: vm
                                        )
                                    )
                            } else {
                                if let url = basicInfoVM.selectedLifePhoto?.contentUrl {
                                    VStack {}
                                        .frame(width: UIScreen.main.bounds.width - 48, height: 342)
                                        .id(2)
                                        .background(
                                            EditableAsyncImage(
                                                basicInfoVM: basicInfoVM,
                                                vm: vm,
                                                url: url
                                            )
                                        )
                                }
                            }

                            HStack(spacing: 12) {
                                TagButton(label: "16:9", tag: .constant(0), isSelected: $vm.selectedTag)
                                TagButton(label: "9:16", tag: .constant(1), isSelected: $vm.selectedTag)
                                TagButton(label: "4:3", tag: .constant(2), isSelected: $vm.selectedTag)
                                TagButton(label: "3:4", tag: .constant(3), isSelected: $vm.selectedTag)
                            }
                            
                            CaptionInputBar(
                                text: $text,
                                hint: "Write a caption...",
                                defaultPresentLine: 8,
                                lineLimit: 8,
                                textLengthLimit: vm.textLengthLimit
                            )
                            .focused($focus)
                            .onChange(of: text) { _ in
                                vm.isSatisfied = true
                            }
                            .onReceive(keyboardPublisher) { val in
                                vm.isKeyboardShowUp = val
                                withAnimation {
                                    scroll.scrollTo(
                                        vm.isKeyboardShowUp ? 1 : 2,
                                        anchor: .top
                                    )
                                }
                            }
                            
                            Spacer().id(1)
                        }
                        .onTapGesture {
                            focus = false
                        }
                    }
                    .scrollDisabled(true)
                }
            },
            footer: {
                vm.isKeyboardShowUp
                ? nil
                : PrimaryButton(
                    label: "Save",
                    action: save,
                    isTappable: $vm.isSatisfied,
                    isLoading: .constant(vm.state == .loading)
                )
                .padding(.bottom, 16)
            }
        )
    }
    
    private func save() {
        if basicInfoVM.selectedImage != nil {
            create()
        } else {
            update()
        }
    }
    
    private func create() {
        Task {
            do {
                let lifePhotos = try await vm.save(
                    data: basicInfoVM.selectedImage?.jpegData(compressionQuality: 0.1),
                    caption: text,
                    position: basicInfoVM.lifePhotoMap.count,
                    scale: 1,
                    offsetX: 0,
                    offsetY: 0
                )
                guard vm.state == .complete else {
                    throw FCError.LifePhoto.createLifePhotoFailed
                }
                basicInfoVM.lifePhotoMap =  Dictionary(
                    uniqueKeysWithValues: lifePhotos.map { ($0.position, $0) }
                )
                dismiss()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func update() {
        
    }
}

struct LifePhotoEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoEditSheet(
            basicInfoVM: BasicInfoViewModel(),
            text: ""
        )
    }
}

extension LifePhotoEditSheet {
    
     struct BackgroundGrid: View {
        
        var geometry: GeometryProxy
        
        var body: some View {
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
        }
    }
    
}
