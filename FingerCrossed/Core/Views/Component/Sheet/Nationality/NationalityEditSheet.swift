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
        
    @State var isAllSelected: Bool = false
    
    var openCountryModel = Nationality(name: "Open to all", code: "OTA")
    
//    // MARK: init
//    init(
//    ) {
//        UITextField.appearance().clearButtonMode = .whileEditing
//    }
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 0
        ) {
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
            .padding(.top, 30)
            
            NationalitySearchBar(
                vm: vm,
                nationalityList: $nationalityList,
                countryName: $countryName
            )
            .padding(.vertical, 20)
            
            countriesListView
        }
        .padding(.horizontal, 24)
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
    }

    var countriesListView: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                isPreference
                ? NationalityItem(
                    nationality: openCountryModel,
                    isSelected: isAllSelected
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    openToAll()
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
            .onChange(of: nationalityList) { _ in
                if nationalityList.contains(where: { $0.name == "Open to all" }) &&
                    nationalityList.count - 1 == vm.nationalities.count {
                    isAllSelected = true
                } else {
                    isAllSelected = false
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

    private func openToAll() {
        let allSelected = nationalityList.contains(where: { item in
            item.name == "Open to all"
        })
        
        print("isAllselected: \(allSelected)")
        
        if allSelected {
            isAllSelected = false
            nationalityList.removeAll()
        } else {
            isAllSelected = true
            nationalityList.removeAll()
            nationalityList.append(openCountryModel)
            for country in vm.nationalities {
                nationalityList.append(country)
            }
        }
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
        }
        else {
            if isPreference {
                nationalityList.append(selectedCountry)
            } else {
                nationalityList.count >= 3
                ? nil
                : nationalityList.append(selectedCountry)
            }
        }
        
        if selectedCountry.name != "Open to all" {
            if nationalityList.count == nationalityList.count - 1 {
                isAllSelected = true
            } else {
                isAllSelected = false
            }
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
