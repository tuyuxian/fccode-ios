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
            VStack(spacing: 16) {
                Text("Zoom in or out to crop the picture")
                    .foregroundColor(Color.text)
                    .fontTemplate(.noteMedium)
                    .frame(height: 16)
                    .padding(.top, 4)
                
                HStack(spacing: 12) {
                    LifePhotoEditSheet.TagButton(
                        label: "3:4",
                        tag: .constant(.ratio1),
                        isSelected: $vm.selectedTag
                    )
                    
                    LifePhotoEditSheet.TagButton(
                        label: "4:3",
                        tag: .constant(.ratio2),
                        isSelected: $vm.selectedTag
                    )
                    
                    LifePhotoEditSheet.TagButton(
                        label: "9:16",
                        tag: .constant(.ratio3),
                        isSelected: $vm.selectedTag
                    )
                    
                    LifePhotoEditSheet.TagButton(
                        label: "16:9",
                        tag: .constant(.ratio4),
                        isSelected: $vm.selectedTag
                    )
                }
                .zIndex(1)
                
                if let image = basicInfoVM.selectedImage {
                    EditableImage(
                        image: { Image(uiImage: image).resizable().scaledToFill() },
                        cropRatio: $vm.selectedTag,
                        currentOffset: $vm.currentOffset,
                        currentScale: $vm.currentScale
                    )
                    .frame(
                        width: UIScreen.main.bounds.width - 48,
                        height: UIScreen.main.bounds.height - 320
                    )
                } else {
                    if let url = basicInfoVM.selectedLifePhoto?.contentUrl {
                        EditableImage(
                            image: { FCAsyncImage(url: URL(string: url)!) },
                            cropRatio: $vm.selectedTag,
                            currentOffset: $vm.currentOffset,
                            currentScale: $vm.currentScale
                        )
                        .onChange(of: vm.currentOffset, perform: { newValue in
                            print("onChangeX: \(newValue.x)")
                            print("onChangeY: \(newValue.y)")
                        })
                        .onChange(of: vm.currentScale, perform: { newValue in
                            print("onChangeScale: \(newValue)")
                        })
                        .frame(
                            width: UIScreen.main.bounds.width - 48,
                            height: UIScreen.main.bounds.height - 320
                        )
                    }
                }
                
                PrimaryButton(
                    label: "Continue",
                    action: { withAnimation { vm.currentView += 1 } },
                    isTappable: .constant(true),
                    isLoading: .constant(false)
                )
            }
            .padding(.bottom, 16)
            .padding(.horizontal, 24)
        }
    }

}

struct LifePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoEditSheet.LifePhotoView(
            basicInfoVM: BasicInfoViewModel(),
            vm: LifePhotoEditSheetViewModel()
        )
    }
}

extension LifePhotoEditSheet {
    
    public enum CropRatio: Int, CaseIterable {
        case ratio1 = 1
        case ratio2 = 2
        case ratio3 = 3
        case ratio4 = 4

        public func size() -> CGSize {
            switch self {
            case .ratio1:
                return .init(
                    width: (UIScreen.main.bounds.width - 48),
                    height: (UIScreen.main.bounds.width - 48) * 4 / 3)
            case .ratio2:
                return .init(
                    width: (UIScreen.main.bounds.width - 48),
                    height: (UIScreen.main.bounds.width - 48) * 3 / 4)
            case .ratio3:
                return .init(
                    width: (UIScreen.main.bounds.height - 320) * 9 / 16,
                    height: (UIScreen.main.bounds.height - 320))
            case .ratio4:
                return .init(
                    width: (UIScreen.main.bounds.width - 48),
                    height: (UIScreen.main.bounds.width - 48) * 9 / 16)
            }
        }
    }

    struct TagButton: View {
        
        let label: String
        
        @Binding var tag: CropRatio
        
        @Binding var isSelected: CropRatio
        
        var body: some View {
            Button {
                isSelected = tag
            } label: {
                Text(label)
                    .foregroundColor(Color.text)
                    .fontTemplate(.noteMedium)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    .background(isSelected == tag ? Color.yellow100 : Color.yellow20)
                    .cornerRadius(50)
            }
        }
    }

}
