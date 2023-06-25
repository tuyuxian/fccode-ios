//
//  LifePhotoStack.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import SwiftUI

struct LifePhotoStack: View {
    
    @ObservedObject var basicInfoVM: BasicInfoViewModel
    
    @ObservedObject var user: UserViewModel
                
    var body: some View {
        Grid(horizontalSpacing: 14) {
            GridRow {
                LifePhotoButton(
                    lifePhoto: $basicInfoVM.lifePhotoMap[0],
                    isEditable: .constant(basicInfoVM.lifePhotoMap.count >= 0),
                    action: { loadLifePhoto(fromIndex: 0) }
                )
                .disabled(!(basicInfoVM.lifePhotoMap.count >= 0))
                
                Grid(horizontalSpacing: 14, verticalSpacing: 14) {
                    GridRow {
                        LifePhotoButton(
                            lifePhoto: $basicInfoVM.lifePhotoMap[1],
                            isEditable: .constant(basicInfoVM.lifePhotoMap.count >= 1),
                            action: { loadLifePhoto(fromIndex: 1) }
                        )
                        .disabled(!(basicInfoVM.lifePhotoMap.count >= 1))
                        
                        LifePhotoButton(
                            lifePhoto: $basicInfoVM.lifePhotoMap[2],
                            isEditable: .constant(basicInfoVM.lifePhotoMap.count >= 2),
                            action: { loadLifePhoto(fromIndex: 2) }
                        )
                        .disabled(!(basicInfoVM.lifePhotoMap.count >= 2))
                    }
                    
                    GridRow {
                        LifePhotoButton(
                            lifePhoto: $basicInfoVM.lifePhotoMap[3],
                            isEditable: .constant(basicInfoVM.lifePhotoMap.count >= 3),
                            action: { loadLifePhoto(fromIndex: 3) }
                        )
                        .disabled(!(basicInfoVM.lifePhotoMap.count >= 3))
                        
                        LifePhotoButton(
                            lifePhoto: $basicInfoVM.lifePhotoMap[4],
                            isEditable: .constant(basicInfoVM.lifePhotoMap.count >= 4),
                            action: { loadLifePhoto(fromIndex: 4) }
                        )
                        .disabled(!(basicInfoVM.lifePhotoMap.count >= 4))
                    }
                }
            }
            .frame(height: 164)
        }
        .onAppear {
            if let lifePhotos = user.data?.lifePhoto {
                basicInfoVM.lifePhotoMap = Dictionary(
                    uniqueKeysWithValues: lifePhotos.map { ($0.position, $0) }
                )
            }
        }
        .onChange(of: basicInfoVM.lifePhotoMap) { val in
            user.data?.lifePhoto = Array(val.values)
        }
        .sheet(isPresented: $basicInfoVM.showEditSheet) {
            if basicInfoVM.hasLifePhoto && basicInfoVM.lifePhotoMap.count == 1 {
                LifePhotoEditSheet(
                    basicInfoVM: basicInfoVM
                )
            } else {
                LifePhotoActionSheet(
                    basicInfoVM: basicInfoVM
                )
            }
        }
    }
    
    private func loadLifePhoto(
        fromIndex: Int
    ) {
        basicInfoVM.showEditSheet = true
        basicInfoVM.selectedLifePhoto = basicInfoVM.lifePhotoMap[fromIndex]
        basicInfoVM.hasLifePhoto = basicInfoVM.lifePhotoMap[fromIndex] != nil
    }
}

struct LifePhotoStack_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoStack(
            basicInfoVM: BasicInfoViewModel(),
            user: UserViewModel(preview: true)
        )
        .padding(.horizontal, 24)
    }
}
