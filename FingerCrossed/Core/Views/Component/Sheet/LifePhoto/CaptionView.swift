//
//  CaptionView.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/22/23.
//

import SwiftUI

extension LifePhotoEditSheet {
    struct CaptionView: View {
        
        @ObservedObject var basicInfoVM: BasicInfoViewModel
        @ObservedObject var vm: LifePhotoEditSheetViewModel
        
        @FocusState private var focus: Bool
        
        var body: some View {
            VStack {
                Text("Tell more about this picture! Or skip this step.")
                    .foregroundColor(Color.text)
                    .fontTemplate(.noteMedium)
                    .frame(height: 16)
                    .padding(.bottom, 30)
                
                CaptionInputBar(
                    text: $vm.caption,
                    hint: "Write a caption...",
                    defaultPresentLine: 8,
                    lineLimit: 8,
                    textLengthLimit: vm.textLengthLimit
                )
                .focused($focus)
                .onChange(of: vm.caption) { _ in
                    vm.isSatisfied = true
                }
    //        .onReceive(keyboardPublisher) { val in
    //            vm.isKeyboardShowUp = val
    //            withAnimation {
    //                scroll.scrollTo(
    //                    vm.isKeyboardShowUp ? 1 : 2,
    //                    anchor: .top
    //                )
    //            }
    //        }
            }

        }
    }

    struct CaptionView_Previews: PreviewProvider {
        static var previews: some View {
            CaptionView(
                basicInfoVM: BasicInfoViewModel(),
                vm: LifePhotoEditSheetViewModel()
            )
        }
    }
}
