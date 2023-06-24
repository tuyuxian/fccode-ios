//
//  CaptionView.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/22/23.
//

import SwiftUI

extension LifePhotoEditSheet {
    struct CaptionView: View, KeyboardReadable {
        @Environment(\.dismiss) private var dismiss
        
        @ObservedObject var basicInfoVM: BasicInfoViewModel
        @ObservedObject var vm: LifePhotoEditSheetViewModel
        
        var body: some View {
            VStack {
                Text("Tell more about this picture! Or skip this step.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.noteMedium)
                    .frame(height: 16)
                    .padding(.bottom, 30)
                
                CaptionInputBar(
                    text: $vm.caption,
                    hint: "Add a caption",
                    defaultPresentLine: 8,
                    lineLimit: 8,
                    textLengthLimit: vm.textLengthLimit
                )
                .onReceive(keyboardPublisher) { val in
                    vm.isKeyboardShowUp = val
                }
                
                Spacer()
                
                PrimaryButton(
                    label: "Save",
                    action: save,
                    isTappable: .constant(true),
                    isLoading: .constant(vm.state == .loading)
                )
                .padding(.bottom, vm.isKeyboardShowUp ? 16 : 20)
                
                !vm.isKeyboardShowUp
                ? Text("Back")
                    .foregroundColor(Color.text)
                    .fontTemplate(.pMedium)
                    .frame(maxWidth: .infinity)
                    .frame(height: 24)
                    .onTapGesture {
                        withAnimation {
                            vm.currentView -= 1
                        }
                    }
                    .padding(.bottom, 16)
                : nil
            }
            
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
                        caption: vm.caption,
                        position: basicInfoVM.lifePhotoMap.count,
                        ratio: vm.selectedTag,
                        scale: vm.currentScale,
                        offsetX: vm.currentOffset.width,
                        offsetY: vm.currentOffset.height
                    )
                    guard vm.state == .complete else {
                        throw FCError.LifePhoto.createLifePhotoFailed
                    }
                    basicInfoVM.lifePhotoMap = Dictionary(
                        uniqueKeysWithValues: lifePhotos.map { ($0.position, $0) }
                    )
                    dismiss()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        private func update() {
            if let lifePhoto = basicInfoVM.selectedLifePhoto {
                Task {
                    do {
                        let lifePhotos = try await vm.update(
                            lifePhotoId: lifePhoto.id,
                            caption: vm.caption,
                            position: lifePhoto.position,
                            ratio: lifePhoto.ratio,
                            scale: lifePhoto.scale,
                            offsetX: lifePhoto.offset.width,
                            offsetY: lifePhoto.offset.height
                        )
                        guard vm.state == .complete else {
                            throw FCError.LifePhoto.updateLifePhotoFailed
                        }
                        basicInfoVM.lifePhotoMap = Dictionary(
                            uniqueKeysWithValues: lifePhotos.map { ($0.position, $0) }
                        )
                        dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
