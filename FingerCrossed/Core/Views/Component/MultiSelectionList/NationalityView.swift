//
//  NationalityView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/10/23.
//

import SwiftUI

struct NationalityView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var nationalityViewModel: NationalityViewModel = NationalityViewModel()
    
    @ObservedObject var nationalitySelectionList: NationalitySelectionList
    
    @State private var countryName: String = ""
    
    @FocusState private var isSearchBarFocused
    
    @Binding var isPreference: Bool
    
    var openCountryModel = Nationality(name: "Open to all", code: "OA")
    
    @State var isAllSelected: Bool = false
    
    // MARK: init
    init(
        nationalitySelectionList: NationalitySelectionList,
        isPreference: Binding<Bool>
    ) {
        self.nationalitySelectionList = nationalitySelectionList
        self._isPreference = isPreference
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                Text("Nationality")
                    .fontTemplate(.h2Medium)
                    .frame(maxWidth: .infinity)

                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(Color.gold)
                    .fontTemplate(.pMedium)
                    .padding(.horizontal, 24)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            .padding(.top, 30)
            
            Text("Up to 3 Nationalities")
                .fontTemplate(.captionMedium)
                .foregroundColor(Color.text)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 14)
                .padding(.top, 3)
                .padding(.bottom, 7)
            
            NationalitySearchBar(
                nationalitySelectionList: nationalitySelectionList,
                countryName: $countryName
            )
            .padding(.horizontal, 24)
            .padding(.vertical, 20)
            
            countriesListView
        }
    }
    // swiftlint: disable line_length
    var countriesListView: some View {
        ScrollView {
            LazyVStack {
                isPreference
                ? NationalityItem(nationality: openCountryModel, isSelected: isAllSelected)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        openToAll()
                    }
                : nil
                
                ForEach(nationalityViewModel.nationalities.filter { (nationality) -> Bool in  self.searchForCountry(nationality.name) }) { nationality in
                    NationalityItem(nationality: nationality, isSelected: isSelected(selected: nationality))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectCountryCode(selectedCountry: nationality)
                        }
                    }
                }
                .onChange(of: nationalitySelectionList.nationalitySelections) { _ in
                    if nationalitySelectionList.nationalitySelections.contains(where: { $0.name == "Open to all" }) && nationalitySelectionList.nationalitySelections.count - 1 == nationalityViewModel.nationalities.count {
                        isAllSelected = true
                    } else {
                        isAllSelected = false
                    }
                }
            }
        }

    // MARK: functions
    private func searchForCountry(_ txt: String) -> Bool {
        return (txt.lowercased(with: .current).hasPrefix(countryName.lowercased(with: .current)) || countryName.isEmpty)
    }
    // swiftlint: enable line_length
    func openToAll() {
        let allSelected = nationalitySelectionList.nationalitySelections.contains(where: { item in
            item.name == "Open to all"
        })
        
        print("isAllselected: \(allSelected)")
        
        if allSelected {
            isAllSelected = false
            nationalitySelectionList.nationalitySelections.removeAll()
        } else {
            isAllSelected = true
            nationalitySelectionList.nationalitySelections.removeAll()
            nationalitySelectionList.nationalitySelections.append(openCountryModel)
            for country in nationalityViewModel.nationalities {
                nationalitySelectionList.nationalitySelections.append(country)
            }
        }
    }
    
    func isSelected(selected: Nationality) -> Bool {
        let contain = nationalitySelectionList.nationalitySelections.first { country in
            country.name == selected.name
        }
        return contain != nil
    }

    func selectCountryCode(selectedCountry: Nationality) {
        if isSelected(selected: selectedCountry) {
            nationalitySelectionList.nationalitySelections.removeAll { country in
                country.name == selectedCountry.name
            }
        }
        else {
            if isPreference {
                nationalitySelectionList.nationalitySelections.append(selectedCountry)
            } else {
                nationalitySelectionList.nationalitySelections.count >= 3
                ? nil
                : nationalitySelectionList.nationalitySelections.append(selectedCountry)
            }
        }
        
        if selectedCountry.name != "Open to all" {
            if nationalitySelectionList.nationalitySelections.count == nationalitySelectionList.nationalitySelections.count - 1 {
                isAllSelected = true
            } else {
                isAllSelected = false
            }
        }

        countryName = ""
        nationalitySelectionList.objectWillChange.send()
        }
}

private var bool: Binding<Bool> {
    Binding.constant(false)
}

struct NationalityView_Previews: PreviewProvider {
    static var previews: some View {
        NationalityView(
            nationalitySelectionList: NationalitySelectionList(
                nationalitySelections: [Nationality]()
            ),
            isPreference: bool
        )
    }
}
