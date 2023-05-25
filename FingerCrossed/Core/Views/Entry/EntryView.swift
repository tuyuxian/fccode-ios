//
//  EntryView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/5/23.
//

import SwiftUI
import GoogleSignIn
import FacebookCore

struct EntryView: View {
    /// Observed global user state
    @ObservedObject var userState: UserStateViewModel
    /// Init new entry view model
    @StateObject var vm: EntryViewModel = EntryViewModel()
        
    let transitionForward: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading)
    )
    
    let transitionBackward: AnyTransition = .asymmetric(
        insertion: .move(edge: .leading),
        removal: .move(edge: .trailing)
    )
    
    var body: some View {
        Group {
            switch vm.switchView {
            case .email:
                EmailView(
                    userState: userState,
                    vm: vm
                )
                .transition(
                    vm.transition == .forward
                    ? transitionForward
                    : transitionBackward
                )
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .onAppear {
                    ApplicationDelegate.shared.application(
                        UIApplication.shared,
                        didFinishLaunchingWithOptions: nil
                    )
                }
            case .password:
                PasswordView(
                    userState: userState,
                    vm: vm
                )
                .transition(
                    vm.transition == .forward
                    ? transitionForward
                    : transitionBackward
                )
                
            case .resetPassword:
                ResetPasswordView(vm: vm)
                    .transition(
                        vm.transition == .forward
                        ? transitionForward
                        : transitionBackward
                    )
 
            case .resetPasswordEmailCheck:
                ResetPasswordEmailCheckView(vm: vm)
                    .transition(
                        vm.transition == .forward
                        ? transitionForward
                        : transitionBackward
                    )
                
            case .resetPasswordOTP:
                ResetPasswordOTPView(vm: vm)
                    .transition(
                        vm.transition == .forward
                        ? transitionForward
                        : transitionBackward
                    )
                
            case .account:
                SignUpAccountView(vm: vm)
                    .transition(
                        vm.transition == .forward
                        ? transitionForward
                        : transitionBackward
                    )
                
            case .name:
                SignUpNameView(vm: vm)
                    .transition(
                        vm.transition == .forward
                        ? transitionForward
                        : transitionBackward
                    )
                
            case .birthday:
                SignUpBirthdayView(vm: vm)
                    .transition(
                        vm.transition == .forward
                        ? transitionForward
                        : transitionBackward
                    )
                
            case .gender:
                SignUpGenderView(vm: vm)
                    .transition(
                        vm.transition == .forward
                        ? transitionForward
                        : transitionBackward
                    )
                
            case .ethnicity:
                SignUpEthnicityView(vm: vm)
                    .transition(
                        vm.transition == .forward
                        ? transitionForward
                        : transitionBackward
                    )
                
            case .nationality:
                SignUpNationalityView(vm: vm)
                    .transition(
                        vm.transition == .forward
                        ? transitionForward
                        : transitionBackward
                    )
                
            case .avatar:
                SignUpAvatarView(vm: vm)
                    .transition(
                        vm.transition == .forward
                        ? transitionForward
                        : transitionBackward
                    )
            case .location:
                SignUpLocationView(vm: vm)
                    .transition(
                        vm.transition == .forward
                        ? transitionForward
                        : transitionBackward
                    )
            }
        }
        .animation(.easeInOut(duration: 0.5), value: vm.switchView)
        .background(Color.background)
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(
            userState: UserStateViewModel()
        )
    }
}
