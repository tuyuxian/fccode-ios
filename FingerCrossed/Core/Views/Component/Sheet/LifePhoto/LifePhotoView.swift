//
//  LifePhotoView.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/22/23.
//

import SwiftUI

extension LifePhotoEditSheet {
    
    struct LifePhotoView: View {
        @ObservedObject var basicInfoVM: BasicInfoViewModel
        @ObservedObject var vm: LifePhotoEditSheetViewModel
        
        var body: some View {
            VStack(spacing: 0) {
                Text("Drag the corners of the picture to crop it.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.noteMedium)
                    .frame(height: 16)
                    .padding(.bottom, 16)
                
                HStack(spacing: 12) {
                    TagButton(label: "16:9", tag: .constant(0), isSelected: $vm.selectedTag)
                    TagButton(label: "9:16", tag: .constant(1), isSelected: $vm.selectedTag)
                    TagButton(label: "4:3", tag: .constant(2), isSelected: $vm.selectedTag)
                    TagButton(label: "3:4", tag: .constant(3), isSelected: $vm.selectedTag)
                }
                .padding(.bottom, 16)
                
                if basicInfoVM.selectedImage != nil {
                    VStack {}
                    .frame(width: UIScreen.main.bounds.width - 48, height: 456)
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
                            .frame(width: UIScreen.main.bounds.width - 48, height: 456)
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
            }
        }
    }
    
    struct LifePhotoView_Previews: PreviewProvider {
        static var previews: some View {
            LifePhotoView(
                basicInfoVM: BasicInfoViewModel(),
                          vm: LifePhotoEditSheetViewModel()
            )
        }
    }
}
