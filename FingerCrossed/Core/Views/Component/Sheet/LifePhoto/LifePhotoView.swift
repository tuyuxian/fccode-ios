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
                Text("Zoom in or out to crop the picture.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.noteMedium)
                    .frame(height: 16)
                    .padding(.bottom, 16)
                
                HStack(spacing: 12) {
                    TagButton(
                        label: Crop.type1.name(),
                        tag: .constant(Crop.type1.tag()),
                        isSelected: $vm.selectedTag
                    )
                    
                    TagButton(
                        label: Crop.type2.name(),
                        tag: .constant(Crop.type2.tag()),
                        isSelected: $vm.selectedTag
                    )
                    
                    TagButton(
                        label: Crop.type3.name(),
                        tag: .constant(Crop.type3.tag()),
                        isSelected: $vm.selectedTag
                    )
                    
                    TagButton(
                        label: Crop.type4.name(),
                        tag: .constant(Crop.type4.tag()),
                        isSelected: $vm.selectedTag
                    )
                }
                .zIndex(2)
                .padding(.bottom, 16)
                
                if basicInfoVM.selectedImage != nil {
                    EditableImage(
                        basicInfoVM: basicInfoVM,
                        vm: vm
                    )
                    .frame(
                        width: (UIScreen.main.bounds.width - 48),
                        height: (UIScreen.main.bounds.height - 320)
                    )
                } else {
                    if let url = basicInfoVM.selectedLifePhoto?.contentUrl {
                        VStack {}
                            .frame(width: UIScreen.main.bounds.width - 48)
                            .background(
                                EditableAsyncImage(
                                    basicInfoVM: basicInfoVM,
                                    vm: vm,
                                    url: url
                                )
                            )
                    }
                }
                
                PrimaryButton(
                    label: "Continue",
                    action: vm.continueOnTap,
                    isTappable: .constant(true),
                    isLoading: .constant(vm.state == .loading)
                )
                .padding(.top, 16)
                .padding(.bottom, 16)
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
