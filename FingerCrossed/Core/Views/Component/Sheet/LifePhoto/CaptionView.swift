//
//  CaptionView.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/22/23.
//

import SwiftUI

extension LifePhotoEditSheet {
    
    struct CaptionView: View, KeyboardReadable {
        /// View controller
        @Environment(\.dismiss) private var dismiss
        /// Observed basic info view model
        @ObservedObject var basicInfoVM: BasicInfoViewModel
        /// Observed life photo edit sheet view model
        @ObservedObject var vm: LifePhotoEditSheetViewModel
        
        var body: some View {
            ScrollView([]) {
                VStack(spacing: 16) {
                    Text("Tell more about this picture! Or skip this step.")
                        .foregroundColor(Color.text)
                        .fontTemplate(.noteMedium)
                        .frame(height: 16)
                        .padding(.top, 4)
                    
                    CaptionInputBar(
                        text: $vm.caption,
                        hint: "Add a caption",
                        defaultPresentLine: 6,
                        lineLimit: 6,
                        textLengthLimit: vm.textLengthLimit
                    )
                    .onReceive(keyboardPublisher) { val in
                        withAnimation(.spring()) {
                            vm.isKeyboardShowUp = val
                        }
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        PrimaryButton(
                            label: "Save",
                            action: save,
                            isTappable: .constant(true),
                            isLoading: .constant(vm.state == .loading)
                        )
                        
                        !vm.isKeyboardShowUp
                        ? Text("Back")
                            .foregroundColor(Color.text)
                            .fontTemplate(.pMedium)
                            .frame(height: 24)
                            .onTapGesture {
                                withAnimation {
                                    vm.currentView -= 1
                                }
                            }
                        : nil
                    }
                }
                .padding(.bottom, 16)
                .padding(.horizontal, 24)
            }
            .scrollDisabled(true)
            .disabled(vm.state == .loading)
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
                        ratio: vm.selectedTag.rawValue,
                        scale: vm.currentScale,
                        offsetX: vm.currentOffset.x,
                        offsetY: vm.currentOffset.y
                    )
                    guard vm.state == .complete else {
                        throw FCError.LifePhoto.createLifePhotoFailed
                    }
                    basicInfoVM.lifePhotoMap = Dictionary(
                        uniqueKeysWithValues: lifePhotos.map { ($0.position, $0) }
                    )
                    dismiss()
                } catch {
                    vm.state = .error
                    vm.showAlert()
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
                            ratio: vm.selectedTag.rawValue,
                            scale: vm.currentScale,
                            offsetX: vm.currentOffset.x,
                            offsetY: vm.currentOffset.y
                        )
                        guard vm.state == .complete else {
                            throw FCError.LifePhoto.updateLifePhotoFailed
                        }
                        basicInfoVM.lifePhotoMap = Dictionary(
                            uniqueKeysWithValues: lifePhotos.map { ($0.position, $0) }
                        )
                        dismiss()
                    } catch {
                        vm.state = .error
                        vm.showAlert()
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

struct CaptionView_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoEditSheet.CaptionView(
            basicInfoVM: BasicInfoViewModel(),
            vm: LifePhotoEditSheetViewModel()
        )
    }
}
