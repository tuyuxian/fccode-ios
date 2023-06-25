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
            header: {
                Text("Nice Picture!")
                    .fontTemplate(.h2Medium)
                    .foregroundColor(Color.text)
                    .frame(height: 34)
                    .padding(.bottom, 4)
            },
            content: {
                TabView(selection: $vm.currentView) {
                    LifePhotoView(basicInfoVM: basicInfoVM, vm: vm)
                        .tag(0)
                        .contentShape(Rectangle()).simultaneousGesture(DragGesture())
                    
                    CaptionView(basicInfoVM: basicInfoVM, vm: vm)
                        .tag(1)
                        .contentShape(Rectangle()).simultaneousGesture(DragGesture())
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .transition(.slide)
            },
            footer: {}
        )
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.16)) {
                UIApplication.shared.closeKeyboard()
            }
        }
    }
}

struct LifePhotoEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoEditSheet(
            basicInfoVM: BasicInfoViewModel()
        )
    }
}
