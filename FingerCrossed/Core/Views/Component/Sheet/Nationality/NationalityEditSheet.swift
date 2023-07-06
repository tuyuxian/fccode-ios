//
//  NationalityEditSheet.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/10/23.
//

import SwiftUI

struct NationalityEditSheet: View {
    
    @Environment(\.dismiss) private var dismiss

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
                    
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Text("Done")
                                .fontTemplate(.pMedium)
                                .foregroundColor(Color.gold)
                                .frame(height: 34, alignment: .center)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal, 24)
            },
            content: {
                Group {
                    NationalitySearchBar(
                        vm: vm,
                        nationalityList: $nationalityList,
                        countryName: $countryName,
                        isSheet: true
                    )
                    .frame(width: UIScreen.main.bounds.width - 50)
                    .padding(.vertical, 20)
                    
                    countriesListView
                }
                .padding(.horizontal, 24)
            },
            footer: {}
        )
    }

    var countriesListView: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                isPreference
                ?
                VStack(spacing: 20) {
                    ForEach(vm.topNationalities) { nationality in
                        NationalityItem(
                            nationality: nationality,
                            isSelected: isSelected(selected: nationality)
                        )
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectCountryCode(selectedCountry: nationality)
                        }
                    }
                    Divider()
                        .overlay(Color.surface2)
                }
                
                : nil
                
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

    private func searchForCountry(
        _ txt: String
    ) -> Bool {
        return txt.lowercased(with: .current).hasPrefix(
            countryName.lowercased(with: .current)
        ) || countryName.isEmpty
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

extension NationalityEditSheet {
    
    struct NationalityItem: View {
        
        let nationality: Nationality
        
        var isSelected: Bool = false
        
        init(
            nationality: Nationality,
            isSelected: Bool
        ) {
            self.nationality = nationality
            self.isSelected = isSelected
        }
        
        var body: some View {
            VStack {
                HStack(
                    alignment: .center,
                    spacing: 6
                ) {
                    Text(nationality.name)
                        .fontTemplate(.pMedium)
                        .foregroundColor(Color.text)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .frame(height: 24)
                    isSelected
                    ? FCIcon.checkCirle
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.gold)
                        .frame(
                            width: 24,
                            height: 24
                        )
                    : nil
                }
            }
        }
    }

}
