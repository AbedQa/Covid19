//
//  SearchBar.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/10/22.
//

import SwiftUI

struct SearchBar: View {
    @State private var searchInput: String = ""
    @Binding var searching: Bool
    @Binding var mainList: [CountryItemViewModel]
    @Binding var searchedList: [CountryItemViewModel]
    
    var body: some View {
        ZStack {
            HStack {
                // Search Bar
                HStack {
                    // Magnifying Glass Icon
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.black)
                    
                    // Search Area TextField
                    TextField("", text: $searchInput)
                        .onChange(of: searchInput, perform: { searchText in
                            searching = true
                            searchedList = mainList.filter { $0.name.lowercased().prefix(searchText.count) == searchText.lowercased() || $0.name.contains(searchText) }
                            
                        })
                        .accentColor(.white)
                        .foregroundColor(.white)
                }
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .background(Color.gray.opacity(0.5).cornerRadius(8.0))
                
                // 'Cancel' Button
                Button(action: {
                    searching = false
                    searchInput = ""
                    
                    // Hide Keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                })
                    .accentColor(Color.black)
                    .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 8))
            }
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
        }
        .frame(height: 50)
    }
}
