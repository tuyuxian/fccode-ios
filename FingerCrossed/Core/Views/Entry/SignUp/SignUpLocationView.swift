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
    @ObservedObject var userState: UserStateViewModel
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
        
        let locationDataManager = LocationDataManager()
        isLoading.toggle()
        switch locationPermissionManger.permissionStatus {
        case .notDetermined:
            locationPermissionManger.requestPermission { granted, _ in
                guard granted else { return }
                vm.latitude = locationDataManager.lastSeenLocation?.coordinate.latitude
                vm.longitude = locationDataManager.lastSeenLocation?.coordinate.longitude
                vm.country = locationDataManager.currentPlacemark?.country
                vm.administrativeArea = locationDataManager.currentPlacemark?.administrativeArea
                isLoading.toggle()
                //                EntryRepository.createUser(
                //                    email: vm.email,
                //                    password: vm.password != "" ? .some(vm.password) : nil,
                //                    username: vm.name,
                //                    dataOfBirth: vm.dateOfBirth,
                //                    gender: GraphQLEnum.case(
                //                        vm.gender?.graphQLValue ?? .preferNotToSay
                //                    ),
                //                    longitude: 0,
                //                    latitude: 0,
                //                    country: .some(""),
                //                    administrativeArea: .some(""),
                //                    googleConnect: .some(vm.googleConnect),
                //                    appleConnect: .some(vm.appleConnect),
                //                    nationality: .some(
                //                        vm.nationality.map { $0.getGraphQLInput() }
                //                    ),
                //                    ethinicty: .some(
                //                        vm.ethnicity.map { $0.getGraphQLInput() }
                //                    ),
                //                    socialAccount: .some(
                //                        [vm.socialAccount.getGraphQLInput()]
                //                    )
                //                ) { _, _, error in
                //                    guard error == nil else {
                //                        isLoading.toggle()
                //                        print(error!)
                //                        bm.banner = .init(
                //                            title: "Something went wrong.",
                //                            type: .error
                //                        )
                //                        return
                //                    }
                //                    userState.isLogin = true
                //                    userState.viewState = .main
                //                }
                
            }
        case .denied:
            showLocationAlert.toggle()
        default:
            vm.latitude = locationDataManager.lastSeenLocation?.coordinate.latitude
            vm.longitude = locationDataManager.lastSeenLocation?.coordinate.longitude
            vm.country = locationDataManager.currentPlacemark?.country
            vm.administrativeArea = locationDataManager.currentPlacemark?.administrativeArea
            isLoading.toggle()
            //            EntryRepository.createUser(
            //                email: vm.email,
            //                password: vm.password != "" ? .some(vm.password) : nil,
            //                username: vm.name,
            //                dataOfBirth: vm.dateOfBirth,
            //                gender: GraphQLEnum.case(
            //                    vm.gender?.graphQLValue ?? .preferNotToSay
            //                ),
            //                longitude: 0,
            //                latitude: 0,
            //                country: .some(""),
            //                administrativeArea: .some(""),
            //                googleConnect: .some(vm.googleConnect),
            //                appleConnect: .some(vm.appleConnect),
            //                nationality: .some(
            //                    vm.nationality.map { $0.getGraphQLInput() }
            //                ),
            //                ethinicty: .some(
            //                    vm.ethnicity.map { $0.getGraphQLInput() }
            //                ),
            //                socialAccount: .some(
            //                    [vm.socialAccount.getGraphQLInput()]
            //                )
            //            ) { _, _, error in
            //                guard error == nil else {
            //                    isLoading.toggle()
            //                    print(error!)
            //                    bm.banner = .init(
            //                        title: "Something went wrong.",
            //                        type: .error
            //                    )
            //                    return
            //                }
            //                userState.isLogin = true
            //                userState.viewState = .main
            //            }
            //        }
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
                        Image("ArrowLeftBased")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.leading, -8) // 16 - 24
                                        
                    EntryLogo()
                }
                .padding(.top, 5)
                .padding(.bottom, 55)
                
                VStack(
                    alignment: .center,
                    spacing: 0
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
                    label: "Continue",
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
            userState: UserStateViewModel(),
            vm: EntryViewModel()
        )
    }
}
