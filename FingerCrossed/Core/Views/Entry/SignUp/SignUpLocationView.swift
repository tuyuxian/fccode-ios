//
//  SignUpLocationView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/24/23.
//

import SwiftUI

struct SignUpLocationView: View {
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    /// Flag for loction permission alert
    @State private var showLocationAlert: Bool = false
    /// Init location permission manager
    let locationPermissionManger = LocationPermissionManager()
    /// Handler for button on tap
    private func buttonOnTap() {
        let locationDataManager = LocationDataManager()
        switch locationPermissionManger.permissionStatus {
        case .notDetermined:
            locationPermissionManger.requestPermission { granted, _ in
                guard granted else { return }
                vm.latitude = Float((locationDataManager.lastSeenLocation?.coordinate.latitude)!)
                vm.longitude = Float((locationDataManager.lastSeenLocation?.coordinate.longitude)!)
                vm.country = locationDataManager.currentPlacemark?.country
                vm.administrativeArea = locationDataManager.currentPlacemark?.administrativeArea
            }
        case .denied:
            showLocationAlert.toggle()
        default:
            vm.latitude = Float((locationDataManager.lastSeenLocation?.coordinate.latitude)!)
            vm.longitude = Float((locationDataManager.lastSeenLocation?.coordinate.longitude)!)
            vm.country = locationDataManager.currentPlacemark?.country
            vm.administrativeArea = locationDataManager.currentPlacemark?.administrativeArea
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
                    isLoading: .constant(false)
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
            vm: EntryViewModel()
        )
    }
}
