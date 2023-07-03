//
//  LifePhotoEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/14/23.
//

import SwiftUI

struct LifePhotoEditSheet: View {
    /// View controller
    @Environment(\.dismiss) private var dismiss
    /// Observed basic info view model
    @ObservedObject var basicInfoVM: BasicInfoViewModel
    /// Init life photo edit sheet view model
    @StateObject private var vm = LifePhotoEditSheetViewModel()
    
    var body: some View {
        Sheet(
            size: [.large],
            hasFooter: false,
            header: {
                Text("Nice Picture!")
                    .fontTemplate(.h2Medium)
                    .foregroundColor(Color.text)
                    .frame(height: 34)
            },
            content: {
                TabView(selection: $vm.currentView) {
                    LifePhotoView(
                        basicInfoVM: basicInfoVM,
                        vm: vm
                    )
                    .tag(0)
                    
                    CaptionView(
                        basicInfoVM: basicInfoVM,
                        vm: vm
                    )
                    .tag(1)
                }
                .tabViewStyle(.automatic)
            },
            footer: {}
        )
        .onTapGesture {
            self.hideKeyboard()
        }
        .onAppear {
            // FIXME: incorrect offset after scaling
            if let selectedLifePhoto = basicInfoVM.selectedLifePhoto {
                vm.selectedTag = CropRatio.allCases.first { ratio in
                    ratio.rawValue == selectedLifePhoto.ratio
                }!
                vm.currentOffset = selectedLifePhoto.offset
                vm.currentScale = selectedLifePhoto.scale
                vm.caption = selectedLifePhoto.caption
            }
        }
    }
    
    private func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

struct LifePhotoEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoEditSheet(
            basicInfoVM: BasicInfoViewModel()
        )
    }
}
