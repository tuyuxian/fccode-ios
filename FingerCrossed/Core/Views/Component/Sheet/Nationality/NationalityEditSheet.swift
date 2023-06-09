//
//  NationalityEditSheet.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/10/23.
//

import SwiftUI

struct NationalityEditSheet: View {
    
    @Environment(\.presentationMode) private var presentationMode

    @ObservedObject var vm: NationalityViewModel
    
    @Binding var nationalityList: [Nationality]
    
    @State private var countryName: String = ""
    
    @Binding var isPreference: Bool
    
    var body: some View {
        Sheet(
            size: [.large],
            hasFooter: false,
            header: {
                ZStack(alignment: .top) {
                    VStack(spacing: 0) {
                        Text("Nationality")
                            .fontTemplate(.h2Medium)
                            .foregroundColor(Color.text)
                            .frame(height: 34)
                        Text("Up to 3 Nationalities")
                            .fontTemplate(.captionMedium)
                            .foregroundColor(Color.text)
                            .frame(height: 14)
                    }
                    
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .fontTemplate(.pMedium)
                    .foregroundColor(Color.gold)
                    .frame(height: 34, alignment: .center)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .trailing
                    )
                }
            },
            content: {
                NationalitySearchBar(
                    vm: vm,
                    nationalityList: $nationalityList,
                    countryName: $countryName,
                    isSheet: true
                )
                .frame(width: UIScreen.main.bounds.width - 50)
                .padding(.vertical, 20)
                
                countriesListView
            },
            footer: {}
        )
    }

    var countriesListView: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(
                    vm.nationalities.filter { nationality -> Bool in
                        self.searchForCountry(nationality.name)
                    }
                ) { nationality in
                    NationalityItem(
                        nationality: nationality,
                        isSelected: isSelected(selected: nationality)
                    )
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectCountryCode(selectedCountry: nationality)
                    }
                }
            }
        }
    }

    // MARK: functions
    private func searchForCountry(
        _ txt: String
    ) -> Bool {
        // swiftlint: disable line_length
        return txt.lowercased(with: .current).hasPrefix(countryName.lowercased(with: .current)) || countryName.isEmpty
        // swiftlint: enable line_length
    }
    
    private func isSelected(
        selected: Nationality
    ) -> Bool {
        let contain = nationalityList.first { country in
            country.name == selected.name
        }
        return contain != nil
    }

    private func selectCountryCode(
        selectedCountry: Nationality
    ) {
        if isSelected(selected: selectedCountry) {
            nationalityList.removeAll { country in
                country.name == selectedCountry.name
            }
        } else {
            nationalityList.count >= 3
            ? nil
            : nationalityList.append(selectedCountry)
        }

        countryName = ""
    }
}

struct NationalityEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        NationalityEditSheet(
            vm: NationalityViewModel(),
            nationalityList: .constant([]),
            isPreference: .constant(false)
        )
    }
}
