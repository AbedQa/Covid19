//
//  CountryListViewModel.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/9/22.
//

import Foundation
import Combine

class CountryListViewModel: ObservableObject, LoadableObject {
    typealias Output = [CountryItemViewModel]
    
    private var disposables = Set<AnyCancellable>()
    private var service: CountryServiceable
    
    @Published var countrySelectedItem: String = ""
    @Published var countryViewModelList: [CountryItemViewModel] = []
    @Published var searchedCountryList = [CountryItemViewModel]()
    @Published var searching = false
    @Published private(set) var state = LoadingState<[CountryItemViewModel]>.idle
    
    // inject this for testability
    init(service: CountryServiceable = CountryService()) {
        self.service = service
    }
    
    func load() {
        state = .loading
        service.countries()
            .map { $0 }
            .replaceEmpty(with: [])
            .sink { response in
                switch response {
                case .failure(_):
                    self.countryViewModelList = self.getAllCountryFromFile().map { CountryItemViewModel(country: $0) }
                    self.searchedCountryList = self.countryViewModelList
                    self.state = .loaded(self.searchedCountryList)
                    break
                case .finished:
                    self.searchedCountryList = self.countryViewModelList
                    self.state = .loaded(self.searchedCountryList)
                }
            } receiveValue: { value in
                self.countryViewModelList = value.map { CountryItemViewModel(country: $0) }
            }.store(in: &disposables)
    }
    
    private func getAllCountryFromFile() -> [Country] {
        do {
            if let countryFilePath = Bundle.main.path(forResource: "CountryMock", ofType: "txt") {
                let offetFileText = try String(contentsOfFile: countryFilePath, encoding: .utf8)
                if let data = offetFileText.data(using: .utf8) {
                    let decodedCountries = try! JSONDecoder().decode([Country].self, from: data)
                    return decodedCountries
                }
                return []
            }
            return []
        } catch {
            return []
        }
    }
}

