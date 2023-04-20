//
//  PreferenceNationalityView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/11/23.
//

import SwiftUI

struct PreferenceNationalityView: View {
    var body: some View {
        ContainerWithHeaderView(parentTitle: "Preference", childTitle: "Nationali") {
            Box {
                VStack(spacing: 0) {
                    CountryView(countryViewModel: CountryViewModel())
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                Spacer()
                TabBar()
            }
        }
    }
}

struct PreferenceNationalityView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceNationalityView()
    }
}
