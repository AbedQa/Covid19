//
//  CountryView.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/9/22.
//

import SwiftUI

struct CountryView: View {
    @ObservedObject var viewModel:CountryListViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let onConfirmSelected: (String) -> Void
    @State private var searchText = ""
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
        }
    }
    
    var confirmSelected : some View {
        Button(action: {
            onConfirmSelected(viewModel.countrySelectedItem)
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "checkmark")
                .foregroundColor(.black)
        }
    }
    var body: some View {
        VStack {
            
            HStack {
                btnBack
                Spacer()
                if !viewModel.countrySelectedItem.isEmpty {
                    confirmSelected
                }
            }
            .padding()
            
            SearchBar(searching: $viewModel.searching, mainList: $viewModel.countryViewModelList, searchedList: $viewModel.searchedCountryList)
            
            AsyncContentView(source: viewModel) { _ in
                List {
                    
                    ForEach(viewModel.searchedCountryList,id:\.id) { countryViewModel in
                        HStack {
                            Text(countryViewModel.name)
                            Spacer()
                            if countryViewModel.name == viewModel.countrySelectedItem {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.accentColor)
                            }
                        }.onTapGesture {
                            withAnimation {
                                self.viewModel.countrySelectedItem = countryViewModel.name
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}
