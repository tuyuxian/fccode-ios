//
//  CountryView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/10/23.
//

import SwiftUI

struct CountryView: View {
    @Environment(\.dismiss) private var dismiss
    @State var countryViewModel: CountryViewModel = CountryViewModel()
    @ObservedObject var countrySelectionList: CountrySelectionList
    @State private var countryName: String = ""
    @FocusState private var isSearchBarFocused
    @Binding var isPreference: Bool
    var openCountryModel = CountryModel(name: "Open to all", code: "OA")
    @State var isAllSelected: Bool = false
    
    // MARK: init
    init(countrySelectionList: CountrySelectionList, isPreference: Binding<Bool>) {
        self.countrySelectionList = countrySelectionList
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
            
            CountrySearchBar(countrySelectionList: countrySelectionList, countryName: $countryName)
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
                ? CountryItemView(countryModel: openCountryModel, isSelected: isAllSelected)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        openToAll()
                    }
                : nil
                
                ForEach(countryViewModel.countries.filter { (countryModel) -> Bool in  self.searchForCountry(countryModel.name) }) { countryModel in
                    CountryItemView(countryModel: countryModel, isSelected: isSelected(selected: countryModel))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectCountryCode(selectedCountry: countryModel)
                        }
                    }
                }
                .onChange(of: countrySelectionList.countrySelections) { _ in
                    if countrySelectionList.countrySelections.contains(where: { $0.name == "Open to all" }) && countrySelectionList.countrySelections.count - 1 == countryViewModel.countries.count {
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
        let allSelected = countrySelectionList.countrySelections.contains(where: { item in
            item.name == "Open to all"
        })
        
        print("isAllselected: \(allSelected)")
        
        if allSelected {
            isAllSelected = false
            countrySelectionList.countrySelections.removeAll()
        } else {
            isAllSelected = true
            countrySelectionList.countrySelections.removeAll()
            countrySelectionList.countrySelections.append(openCountryModel)
            for country in countryViewModel.countries {
                countrySelectionList.countrySelections.append(country)
            }
        }
    }
    
    func isSelected (selected: CountryModel) -> Bool {
        let contain = countrySelectionList.countrySelections.first { country in
            country.name == selected.name
        }
        return contain != nil
    }

    func selectCountryCode(selectedCountry: CountryModel) {
        if isSelected(selected: selectedCountry) {
            countrySelectionList.countrySelections.removeAll { country in
                country.name == selectedCountry.name
            }
        }
        else {
            if isPreference {
                countrySelectionList.countrySelections.append(selectedCountry)
            } else {
                countrySelectionList.countrySelections.count >= 3 ? nil
                : countrySelectionList.countrySelections.append(selectedCountry)
            }
        }
        
        if selectedCountry.name != "Open to all" {
            if countryViewModel.countries.count == countrySelectionList.countrySelections.count - 1 {
                isAllSelected = true
            } else {
                isAllSelected = false
            }
        }

        countryName = ""
        countrySelectionList.objectWillChange.send()
        }
}

private var bool: Binding<Bool> {
    Binding.constant(false)
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(
            countrySelectionList: CountrySelectionList(countrySelections: [CountryModel]()),
            isPreference: bool
        )
    }
}
