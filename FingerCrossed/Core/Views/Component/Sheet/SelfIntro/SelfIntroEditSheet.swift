//
//  SelfIntroEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/25/23.
//

import SwiftUI
import GraphQLAPI

struct SelfIntroEditSheet: View {

    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var vm: BasicInfoViewModel
    
    @AppStorage("UserId") private var userId: String = ""
    
    @State var text: String = ""
    
    @State private var isSatisfied: Bool = false
    
    @State private var isLoading: Bool = false
            
    let textLengthLimit: Int = 200
    
    private func save() {
        Task {
            do {
                isLoading.toggle()
                let statusCode = try await UserService.updateUser(
                    userId: userId,
                    input: GraphQLAPI.UpdateUserInput(
                        selfIntro: .some(text)
                    )
                )
                isLoading.toggle()
                guard statusCode == 200 else {
                    vm.state = .error
                    vm.bannerMessage = "Something went wrong"
                    vm.bannerType = .error
                    return
                }
                vm.user.selfIntro = text
                dismiss()
            } catch {
                isLoading.toggle()
                vm.state = .error
                vm.bannerMessage = "Something went wrong"
                vm.bannerType = .error
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        Sheet(
            size: [.height(402)],
            hasFooter: false,
            header: {
                Text("Self Introduction")
                    .fontTemplate(.h2Medium)
                    .foregroundColor(Color.text)
                    .frame(height: 34)
            },
            content: {
                VStack(spacing: 0) {
                    CaptionInputBar(
                        text: $text,
                        hint: "Type your self introduction",
                        defaultPresentLine: 10,
                        lineLimit: 10,
                        textLengthLimit: textLengthLimit
                    )
                    .frame(height: 244)
                    .padding(.top, 16)
                    .padding(.bottom, 10)
                    .onChange(of: text) { _ in
                        isSatisfied = true
                    }
                    
                    PrimaryButton(
                        label: "Save",
                        action: save,
                        isTappable: $isSatisfied,
                        isLoading: $isLoading
                    )
                    .padding(.bottom, 16)
                }
            },
            footer: {}
        )
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.16)) {
                UIApplication.shared.closeKeyboard()
            }
        }
        .interactiveDismissDisabled(isLoading)
    }
}

struct SelfIntroEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        SelfIntroEditSheet(
            vm: BasicInfoViewModel(user: User.MockUser)
        )
    }
}
