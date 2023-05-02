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
    @State private var scrollTarget: String?
    @FocusState private var isSearchBarFocused
    
    
    //MARK: init
    init(countrySelectionList: CountrySelectionList){
        self.countrySelectionList = countrySelectionList
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
            
            
//            searchBar
//                .padding(.horizontal, 24)
//                .padding(.vertical, 20)
            
            countriesListView
        }
    }
    
    var searchBar: some View {
        HStack (alignment: .top, spacing: 0){
            if countrySelectionList.countrySlections.count >= 1 {
                VStack (alignment: .leading, spacing: 10.0){
                    countrySelectionList.countrySlections.count >= 3 ? nil
                    : TextField("",
                              text: $countryName,
                              prompt: Text("Search").foregroundColor(.textHelper).font(Font.system(size: 16, weight: .regular)))
                                .fontTemplate(.pRegular)
                                .foregroundColor(Color.text)
                                .frame(height: 24)
                                .padding(.leading, 8)
                                .padding(.bottom, 0)
                                .focused($isSearchBarFocused)
                                .onAppear {
                                    isSearchBarFocused = false
                                }
                    
                    VStack (alignment: .leading, spacing: 10.0) {
                        countrySelectionList.countrySlections.count >= 3 ? nil : Divider()
                        
                        ForEach(countrySelectionList.countrySlections) { countryselected in
                            
                            HStack (spacing: 8.0){
                                Text(countryselected.name)
                                    .padding(.leading, 10)
                                    .padding(.vertical, 6)
                                
                                Button{
                                    countrySelectionList.countrySlections.removeAll(where: { $0 == countryselected })
                                } label: {
                                    Image("CloseCircle")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                                .padding(.trailing, 10)
                                .padding(.vertical, 6)
                            }
                            .frame(height: 36)
                            .background(
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color.yellow20)
                            )
                        }
                    }
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }else {
                HStack {
                    HStack (spacing: 8.0) {
                        ForEach(countrySelectionList.countrySlections) { countryselected in
                            
                            HStack (spacing: 8.0){
                                Text(countryselected.name)
                                    .padding(.leading, 10)
                                    .padding(.vertical, 6)
                                
                                Button{
                                    countrySelectionList.countrySlections.removeAll(where: { $0 == countryselected })
                                } label: {
                                    Image("CloseCircle")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                                .padding(.trailing, 10)
                                .padding(.vertical, 6)
                            }
                            .frame(height: 36)
                            .background(
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color.yellow20)
                            )
                        }
                    }
                    
                    TextField("",
                              text: $countryName,
                              prompt: Text("Search").foregroundColor(.textHelper).font(Font.system(size: 16, weight: .regular)))
                        .fontTemplate(.pRegular)
                        .foregroundColor(Color.text)
                        .focused($isSearchBarFocused)
                        .onAppear {
                            isSearchBarFocused = false
                        }
                }
            }
            
            Image(systemName: "magnifyingglass").foregroundColor(Color.text)
                .padding(.top, 5)
        }
        .environmentObject(countrySelectionList)
        .frame(maxWidth: .infinity)
        .frame(height: countrySelectionList.countrySlections.count >= 1 ? (countrySelectionList.countrySlections.count >= 2 ? 160 : 108) : 56)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: countrySelectionList.countrySlections.count >= 1 ? 26 : 50)
                .stroke(Color.surface2, lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color.white)
                )
        )
    }
    
    
    var countriesListView: some View {
        ScrollView {
            ScrollViewReader { scrollProxy in
                LazyVStack(pinnedViews:[.sectionHeaders]) {
                    ForEach(countryViewModel.sections.filter{ self.searchForSection($0)}, id: \.self) { letter in
                        Section() {
                            ForEach(countryViewModel.countries.filter{ (countryModel) -> Bool in countryModel.name.prefix(1) == letter && self.searchForCountry(countryModel.name) }) { countryModel in
//                                CountryItemView(countryModel: countryModel, isSelected: (countryModel.code == countryViewModel.code) ? true : false)
                                CountryItemView(countryModel: countryModel, isSelected: (countrySelectionList.countrySlections.contains(countryModel)))
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        selectCountryCode(selectedCountry: countryModel)
                                    }
                            }
                        }
                    }
                }
                .onChange(of: scrollTarget) { target in
                    if let target = target {
                        scrollTarget = nil
                        withAnimation {
                            scrollProxy.scrollTo(target, anchor: .topLeading)
                        }
                    }
                }
            }
        }
    }

    
    //MARK: functions
    private func searchForCountry(_ txt: String) -> Bool {
        return (txt.lowercased(with: .current).hasPrefix(countryName.lowercased(with: .current)) || countryName.isEmpty)
    }

    private func searchForSection(_ txt: String) -> Bool {
        return (txt.prefix(1).lowercased(with: .current).hasPrefix(countryName.prefix(1).lowercased(with: .current)) || countryName.isEmpty)
    }
    
    func selectCountryCode(selectedCountry: CountryModel){
            //countryViewModel.countryCodeNumber = selectedCountry.dial_code
//        countryViewModel.country = selectedCountry.name
//        countryViewModel.code = selectedCountry.code
        
        if countrySelectionList.countrySlections.contains(selectedCountry) {
            countrySelectionList.countrySlections.removeAll(where: { $0 == selectedCountry })
        }
        else {
            countrySelectionList.countrySlections.count >= 3 ? nil
            : countrySelectionList.countrySlections.append(selectedCountry)
        }
        
        //countrySelections.append(selectedCountry)
        countryName = ""
        countrySelectionList.objectWillChange.send()
        print(countrySelectionList.countrySlections.count)
        
        }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(countrySelectionList: CountrySelectionList(countrySlections: [CountryModel]()))
    }
}


