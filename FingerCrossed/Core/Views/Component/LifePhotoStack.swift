//
//  LifePhotoStack.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import SwiftUI

struct LifePhotoStack: View {
    
    @ObservedObject var vm: ProfileViewModel
    
    @StateObject var hapticHelper: HapticsHelper = HapticsHelper()

    var body: some View {
        GeometryReader { proxy in
            LazyHStack(spacing: 14) {
                ForEach(
                    Array(vm.user.lifePhoto[0...0].enumerated()),
                    id: \.element.id
                ) { index, lifePhoto in
                    LifePhotoButton(
                        vm: vm,
                        position: index,
                        halfSize: (proxy.size.width - 42)/4,
                        fullSize: (proxy.size.width - 14)/2
                     )
                    .onDrag({
                        hapticHelper.impactFeedback.impactOccurred()
                        vm.currentDragLifePhoto = lifePhoto
                        return NSItemProvider(contentsOf: URL(string: "\(lifePhoto.id)")!)!
                    })
                    .onDrop(
                        of: [.url],
                        delegate:
                            DropViewDelegate(
                                lifePhoto: lifePhoto,
                                vm: vm
                            )
                    )
                }
                
                LazyVStack(spacing: 14) {
                    LazyHStack(spacing: 14) {
                        ForEach(
                            Array(vm.user.lifePhoto[1...2].enumerated()),
                            id: \.element.id
                        ) { index, lifePhoto in
                            if lifePhoto.photoUrl != "" {
                                LifePhotoButton(
                                    vm: vm,
                                    position: index + 1,
                                    halfSize: (proxy.size.width - 42)/4,
                                    fullSize: (proxy.size.width - 14)/2
                                )
                                .onDrag({
                                    hapticHelper.impactFeedback.impactOccurred()
                                    vm.currentDragLifePhoto = lifePhoto
                                    return NSItemProvider(contentsOf: URL(string: "\(lifePhoto.id)")!)!
                                })
                                .onDrop(
                                    of: [.url],
                                    delegate:
                                        DropViewDelegate(
                                            lifePhoto: lifePhoto,
                                            vm: vm
                                        )
                                )
                            } else {
                                LifePhotoButton(
                                    vm: vm,
                                    position: index + 1,
                                    halfSize: (proxy.size.width - 42)/4,
                                    fullSize: (proxy.size.width - 14)/2
                                )
                            }
                        }
                    }
                    
                    LazyHStack(spacing: 14) {
                        ForEach(
                            Array(vm.user.lifePhoto[3...4].enumerated()),
                            id: \.element.id
                        ) { index, lifePhoto in
                            if lifePhoto.photoUrl != "" {
                                LifePhotoButton(
                                    vm: vm,
                                    position: index + 3,
                                    halfSize: (proxy.size.width - 42)/4,
                                    fullSize: (proxy.size.width - 14)/2
                                )
                                .onDrag({
                                    hapticHelper.impactFeedback.impactOccurred()
                                    vm.currentDragLifePhoto = lifePhoto
                                    return NSItemProvider(contentsOf: URL(string: "\(lifePhoto.id)")!)!
                                })
                                .onDrop(
                                    of: [.url],
                                    delegate:
                                        DropViewDelegate(
                                            lifePhoto: lifePhoto,
                                            vm: vm
                                        )
                                )
                            } else {
                                LifePhotoButton(
                                    vm: vm,
                                    position: index + 3,
                                    halfSize: (proxy.size.width - 42)/4,
                                    fullSize: (proxy.size.width - 14)/2
                                )
                            }
                        }
                    }
                }
                .frame(
                    width: (proxy.size.width - 14)/2,
                    height: (proxy.size.width - 14)/2
                )
            }
            .frame(
                width: proxy.size.width,
                height: (proxy.size.width - 14)/2
            )
            .sheet(isPresented: $vm.showEditSheet) {
                LifePhotoActionSheet(vm: vm)
            }
        }
    }
}

struct LifePhotoStack_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoStack(
            vm: ProfileViewModel()
        )
        .padding(.horizontal, 24)
    }
}

struct DropViewDelegate: DropDelegate {

    var lifePhoto: LifePhoto
    
    var vm: ProfileViewModel
    
    func performDrop(
        info: DropInfo
    ) -> Bool {
        return true
    }
    
    func dropEntered(
        info: DropInfo
    ) {
        let fromIndex = vm.user.lifePhoto.firstIndex { (lifePhoto) -> Bool in
            return lifePhoto.id == vm.currentDragLifePhoto?.id
        } ?? 0
        
        let toIndex = vm.user.lifePhoto.firstIndex { (lifePhoto) -> Bool in
            return lifePhoto.id == self.lifePhoto.id
        } ?? 0
        
        if fromIndex != toIndex {
            let fromLifePhoto = vm.user.lifePhoto[fromIndex]
            vm.user.lifePhoto[fromIndex] = vm.user.lifePhoto[toIndex]
            vm.user.lifePhoto[fromIndex].position = fromIndex
            vm.user.lifePhoto[toIndex] = fromLifePhoto
            vm.user.lifePhoto[toIndex].position = toIndex
        }
    }
    
    func dropUpdated(
        info: DropInfo
    ) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
}

class HapticsHelper: ObservableObject {
    @Published var impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        
    init() {
        impactFeedback.prepare()
    }
}
