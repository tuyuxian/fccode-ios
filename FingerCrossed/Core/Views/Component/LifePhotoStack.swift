//
//  LifePhotoStack.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import SwiftUI

struct LifePhotoStack: View {
    
    @ObservedObject var vm: BasicInfoViewModel
                
    @StateObject var hm = HapticsManager()

    var body: some View {
        Grid(horizontalSpacing: 14) {
//            GridRow {
//                LifePhotoButton(
//                    lifePhoto: $vm.lifePhotoMap[0],
//                    isEditable: .constant(vm.lifePhotoMap.count >= 0),
//                    showEditSheet: $vm.showEditSheet,
//                    hasLifePhoto: $vm.hasLifePhoto,
//                    selectedLifePhoto: $vm.selectedLifePhoto
//                )
//                .dragAndDropModifier(
//                    perform:
//                        vm.lifePhotoMap[0]?.contentUrl != "" &&
//                        vm.lifePhotoMap[0]?.contentUrl != nil,
//                    lifePhoto: $vm.lifePhotoMap[0],
//                    vm: vm,
//                    hm: hm
//                )
//                .disabled(!(vm.lifePhotoMap.count >= 0))
//
//                Grid(horizontalSpacing: 14, verticalSpacing: 14) {
//                    GridRow {
//                        LifePhotoButton(
//                            lifePhoto: $vm.lifePhotoMap[1],
//                            isEditable: .constant(vm.lifePhotoMap.count >= 1),
//                            showEditSheet: $vm.showEditSheet,
//                            hasLifePhoto: $vm.hasLifePhoto,
//                            selectedLifePhoto: $vm.selectedLifePhoto
//                        )
//                        .dragAndDropModifier(
//                            perform:
//                                vm.lifePhotoMap[1]?.contentUrl != "" &&
//                                vm.lifePhotoMap[1]?.contentUrl != nil,
//                            lifePhoto: $vm.lifePhotoMap[1],
//                            vm: vm,
//                            hm: hm
//                        )
//                        .disabled(!(vm.lifePhotoMap.count >= 1))
//
//                        LifePhotoButton(
//                            lifePhoto: $vm.lifePhotoMap[2],
//                            isEditable: .constant(vm.lifePhotoMap.count >= 2),
//                            showEditSheet: $vm.showEditSheet,
//                            hasLifePhoto: $vm.hasLifePhoto,
//                            selectedLifePhoto: $vm.selectedLifePhoto
//                        )
//                        .dragAndDropModifier(
//                            perform:
//                                vm.lifePhotoMap[2]?.contentUrl != "" &&
//                                vm.lifePhotoMap[2]?.contentUrl != nil,
//                            lifePhoto: $vm.lifePhotoMap[2],
//                            vm: vm,
//                            hm: hm
//                        )
//                        .disabled(!(vm.lifePhotoMap.count >= 2))
//                    }
//                    GridRow {
//                        LifePhotoButton(
//                            lifePhoto: $vm.lifePhotoMap[3],
//                            isEditable: .constant(vm.lifePhotoMap.count >= 3),
//                            showEditSheet: $vm.showEditSheet,
//                            hasLifePhoto: $vm.hasLifePhoto,
//                            selectedLifePhoto: $vm.selectedLifePhoto
//                        )
//                        .dragAndDropModifier(
//                            perform:
//                                vm.lifePhotoMap[3]?.contentUrl != "" &&
//                                vm.lifePhotoMap[3]?.contentUrl != nil,
//                            lifePhoto: $vm.lifePhotoMap[3],
//                            vm: vm,
//                            hm: hm
//                        )
//                        .disabled(!(vm.lifePhotoMap.count >= 3))
//
//                        LifePhotoButton(
//                            lifePhoto: $vm.lifePhotoMap[4],
//                            isEditable: .constant(vm.lifePhotoMap.count >= 4),
//                            showEditSheet: $vm.showEditSheet,
//                            hasLifePhoto: $vm.hasLifePhoto,
//                            selectedLifePhoto: $vm.selectedLifePhoto
//                        )
//                        .dragAndDropModifier(
//                            perform:
//                                vm.lifePhotoMap[4]?.contentUrl != "" &&
//                                vm.lifePhotoMap[4]?.contentUrl != nil,
//                            lifePhoto: $vm.lifePhotoMap[4],
//                            vm: vm,
//                            hm: hm
//                        )
//                        .disabled(!(vm.lifePhotoMap.count >= 4))
//                    }
//                }
//            }
//            .frame(height: 164)
        }
//        .sheet(isPresented: $vm.showEditSheet) {
//            if vm.hasLifePhoto && vm.lifePhotoMap.count == 1 {
//                LifePhotoEditSheet(
//                    vm: vm,
//                    text: vm.selectedLifePhoto?.caption ?? ""
//                )
//            } else {
//                LifePhotoActionSheet(vm: vm)
//            }
//        }
    }
}

//struct LifePhotoStack_Previews: PreviewProvider {
//    static var previews: some View {
//        LifePhotoStack(
//            vm: BasicInfoViewModel(user: User.MockUser)
//        )
//        .padding(.horizontal, 24)
//    }
//}
//
//private extension LifePhotoStack {
//    struct DropViewDelegate: DropDelegate {
//    
//        var lifePhoto: LifePhoto?
//
//        var vm: BasicInfoViewModel
//
//        var hm: HapticsManager
//
//        func performDrop(
//            info: DropInfo
//        ) -> Bool {
//            return true
//        }
//
//        func dropEntered(
//            info: DropInfo
//        ) {
//            let fromIndex = vm.user.lifePhoto.firstIndex { (lifePhoto) -> Bool in
//                return lifePhoto.id == vm.currentDragLifePhoto?.id
//            } ?? 0
//
//            let toIndex = vm.user.lifePhoto.firstIndex { (lifePhoto) -> Bool in
//                return lifePhoto.id == self.lifePhoto?.id
//            } ?? 0
//
//            if fromIndex != toIndex {
//                hm.impactFeedback.impactOccurred()
//                let fromLifePhoto = vm.user.lifePhoto[fromIndex]
//                vm.user.lifePhoto[fromIndex] = vm.user.lifePhoto[toIndex]
//                vm.user.lifePhoto[fromIndex].position = fromIndex
//                vm.user.lifePhoto[toIndex] = fromLifePhoto
//                vm.user.lifePhoto[toIndex].position = toIndex
//            }
//        }
//
//        func dropUpdated(
//            info: DropInfo
//        ) -> DropProposal? {
//            return DropProposal(operation: .move)
//        }
//    }
//    
//    struct DragAndDropModifier: ViewModifier {
//        let lifePhoto: Binding<LifePhoto?>
//        let vm: BasicInfoViewModel
//        let hm: HapticsManager
//
//        func body(
//            content: Content
//        ) -> some View {
//            content
//                .onDrag {
//                    hm.impactFeedback.impactOccurred()
//                    vm.currentDragLifePhoto = lifePhoto.wrappedValue
//                    return NSItemProvider(
//                        object: String(
//                            describing: lifePhoto.wrappedValue?.id
//                        ) as NSString
//                    )
//                }
//                .onDrop(of: [.url], delegate: DropViewDelegate(
//                    lifePhoto: lifePhoto.wrappedValue,
//                    vm: vm,
//                    hm: hm
//                ))
//        }
//    }
//    
//}
//
//extension View {
//
//    @ViewBuilder
//    func dragAndDropModifier(
//        perform: Bool,
//        lifePhoto: Binding<LifePhoto?>,
//        vm: BasicInfoViewModel,
//        hm: HapticsManager
//    ) -> some View {
//        if perform {
//            self.modifier(
//                LifePhotoStack.DragAndDropModifier(
//                    lifePhoto: lifePhoto,
//                    vm: vm,
//                    hm: hm
//                )
//            )
//        } else {
//            self
//        }
//    }
//
//}
