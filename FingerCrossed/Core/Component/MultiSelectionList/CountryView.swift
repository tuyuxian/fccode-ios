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
    @StateObject var countrySelectionList = CountrySelectionList(countrySlections: [CountryModel]())
    @State private var countryName: String = ""
    @State private var scrollTarget: String?
    @FocusState private var isSearchBarFocused
    
    
    //MARK: init
    init(countryViewModel: CountryViewModel){
        self.countryViewModel = countryViewModel
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            ZStack {
                Text("Nationality")
                    .font(.h2Medium)
                    .frame(maxWidth: .infinity)

                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(Color.orange100)
                    .font(.pMedium)
                    .padding(.horizontal, 24)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            .padding(.top, 30)
            
            Text("Up to 3 Nationalities")
                .font(.captionMedium)
                .foregroundColor(Color.text)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 14)
                .padding(.top, 3)
                .padding(.bottom, 10)
            
            
            searchBar
                .padding(.horizontal, 24)
                .padding(.vertical, 20)
            
            countriesListView
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var searchBar: some View {
        HStack {
            ForEach(countrySelectionList.countrySlections) { countryselected in
                HStack (spacing: 4.0){
                    Text(countryselected.name)
                        .padding(.leading, 8)
                        .padding(.vertical, 6)
                    
                    Button{
                        countrySelectionList.countrySlections.removeAll(where: { $0 == countryselected })
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                    .padding(.trailing, 8)
                }
                .frame(height: 32)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color.orange60)
                )
            }
            
            TextField("", text: $countryName, prompt: Text("Search").foregroundColor(.textHelper).font(.pRegular))
                .font(.pRegular)
                .foregroundColor(Color.text)
                .frame(height: 56)
                .focused($isSearchBarFocused)
                .onAppear {
                    isSearchBarFocused = false
                }
            
            Image(systemName: "magnifyingglass").foregroundColor(Color.text)
        }
        .environmentObject(countrySelectionList)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 50)
                .stroke(Color.surface2, lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color.white)
                )
            .frame(height: 56)
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
            countrySelectionList.countrySlections.append(selectedCountry)
        }
        
        //countrySelections.append(selectedCountry)
        countryName = ""
        countrySelectionList.objectWillChange.send()
        print(countrySelectionList.countrySlections.count)
        
        }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(countryViewModel: CountryViewModel())
    }
}


