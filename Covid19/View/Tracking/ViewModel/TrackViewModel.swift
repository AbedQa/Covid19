//
//  TrackViewModel.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/10/22.
//

import Foundation
import Combine

class TrackViewModel: ObservableObject, LoadableObject {
    typealias Output = [TrackItemViewModel]
    
    
    private var service: TrackServiceable
    private var trackListItemViewModel: [TrackItemViewModel] = []
    private var disposables = Set<AnyCancellable>()
    
    @Published private(set) var state = LoadingState<[TrackItemViewModel]>.idle
    @Published var countrySelectedItem: String = "Afghanistan"
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()

    // inject this for testability
    init(service: TrackServiceable = TrackService()) {
        self.service = service
    }
    
    func load() {
        state = .loading
        service.tracking(startDate: startDate.toString(), endDate: endDate.toString(), countryName: countrySelectedItem)
            .map { $0 }
            .sink { response in
                switch response {
                case .failure(let error):
                    self.state = .failed(error)
                    break
                case .finished:
                    self.state = .loaded(self.trackListItemViewModel)
                }
            } receiveValue: { value in
                self.setupData(total: value.total)
            }.store(in: &disposables)
    }
    
    private func setupData(total: Total?) {
        guard let total = total else {
            return
        }
        
        self.trackListItemViewModel = [
            .init(casesNumber: total.todayOpenCases, image: "confirmed",title: "Confirmed Cases"),
            .init(casesNumber: total.todayDeaths, image: "totalDeath",title: "Total Death"),
            .init(casesNumber: total.todayRecovered, image: "recovered",title: "Total Recovered"),
            .init(casesNumber: total.todayNewOpenCases, image: "newCases",title: "New Cases")
        ]
    }
    
    public func refershData() {
        state = .idle
    }
    
    func updateCountry(countryName: String) {
        self.countrySelectedItem = countryName.lowercased()
        state = .idle
    }
}

