//
//  SignUpLocationView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/24/23.
//

import SwiftUI
import GraphQLAPI

struct SignUpLocationView: View {
    /// Global banner
    @EnvironmentObject var bm: BannerManager
    /// Observed user state view model
    @ObservedObject var usm: UserStateManager
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    /// Flag for loction permission alert
    @State private var showLocationAlert: Bool = false
    /// Flag for loading state
    @State private var isLoading: Bool = false
    /// Init location permission manager
    let locationPermissionManger = LocationPermissionManager()
    /// Handler for button on tap
    private func buttonOnTap() {
        isLoading.toggle()
        switch locationPermissionManger.permissionStatus {
        case .notDetermined:
            locationPermissionManger.requestPermission { granted, _ in
                guard granted else { return }
                createUser()
            }
        case .denied:
            isLoading.toggle()
            showLocationAlert.toggle()
        default:
            createUser()
        }
    }
    /// Handler for create user
    private func createUser() {
        let locationDataManager = LocationDataManager()
        Task {
            do {
                try await Task.sleep(nanoseconds: 500_000_000)
                vm.user.latitude = locationDataManager.lastSeenLocation?.coordinate.latitude ?? 0
                vm.user.longitude = locationDataManager.lastSeenLocation?.coordinate.longitude ?? 0
                vm.user.country = locationDataManager.currentPlacemark?.country ?? ""
                vm.user.administrativeArea = locationDataManager.currentPlacemark?.administrativeArea ?? ""
                let url = try await MediaService.getPresignedPutUrl(
                    .case(.image)
                )
                let result = try await AWSS3.uploadImage(
                    vm.selectedImage?.jpegData(compressionQuality: 0.1),
                    toPresignedURL: URL(string: url!)!
                )
                vm.user.profilePictureUrl = result.absoluteString
                vm.user.lifePhoto.append(
                    LifePhoto(
                        id: "0",
                        contentUrl: result.absoluteString,
                        caption: "",
                        position: 0,
                        ratio: 3,
                        scale: 1,
                        offset: CGSize.zero
                    )
                )
                let (userId, token) = try await UserService.createUser(
                    input: vm.user.getGraphQLInput()
                )
                isLoading.toggle()
                usm.userId = userId
                usm.token = token
                usm.isLogin = true
                usm.viewState = .main
            } catch {
                isLoading.toggle()
                print(error.localizedDescription)
                bm.pop(
                    title: "Something went wrong.",
                    type: .error
                )
            }
        }
    }
    
    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .center,
                vertical: .top
            )
        ) {
            Color.background.ignoresSafeArea(.all)
            
            VStack(
                alignment: .leading,
                spacing: 0
            ) {
                HStack(
                    alignment: .center,
                    spacing: 92
                ) {
                    Button {
                        vm.transition = .backward
                        vm.switchView = .avatar
                    } label: {
                        FCIcon.arrowLeft
                    }
                    .padding(.leading, -8) // 16 - 24
                                        
                    EntryLogo()
                }
                .padding(.top, 5)
                .padding(.bottom, 55)
                
                VStack(
                    alignment: .center,
                    spacing: 20
                ) {
                    Text("Your location matters")
                        .fontTemplate(.bigBoldTitle)
                        .foregroundColor(Color.text)
                        .multilineTextAlignment(.center)
                    Text("You won't miss out on potential matches in your area!")
                        .fontTemplate(.h3Bold)
                        .foregroundColor(Color.text)
                        .multilineTextAlignment(.center)
                    LottieView(
                        lottieFile: "location.json"
                    )
                    .frame(
                        width: 320,
                        height: 320
                    )
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
                
                PrimaryButton(
                    label: "Sure",
                    action: buttonOnTap,
                    isTappable: .constant(true),
                    isLoading: $isLoading
                )
                .padding(.bottom, 16)
                .alert(isPresented: $showLocationAlert) {
                    Alert(
                        title:
                            Text(locationPermissionManger.alertTitle)
                            .font(Font.system(size: 18, weight: .medium)),
                        message:
                            Text(locationPermissionManger.alertMessage)
                            .font(Font.system(size: 12, weight: .medium)),
                        primaryButton: .default(Text("Cancel")),
                        secondaryButton: .default(
                            Text("Settings"),
                            action: {
                                UIApplication.shared.open(
                                    URL(string: UIApplication.openSettingsURLString)!
                                )
                            }
                        )
                    )
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

struct SignUpLocationView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpLocationView(
            usm: UserStateManager(),
            vm: EntryViewModel()
        )
    }
}
