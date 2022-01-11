//
//  AirportViewModel.swift
//  QantasAirportApp
//
//  Created by sonam taya on 10/1/22.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func fetchDidSucceed()
    func fetchDidFail(with title: String, description: String)
}

final class AirportViewModel {
    private weak var delegate: ViewModelDelegate?
    
    init(delegate: ViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Variables and Properties
    
    var apiClient = APIClient()
    var airportData: [Airport]? = nil
    
    // MARK: - Fetch Data
    
    func fetchAirports(with url: URL) {
        apiClient.fetch(with: url, page: nil, dataType: [Airport].self) { result in
            switch result {
            case .failure(let error):
                // Perform on main thread to update UI
                DispatchQueue.main.async {
                    self.delegate?.fetchDidFail(with: error.reason, description: error.localizedDescription)
                }
            case .success(let response):
                // Perform on main thread to update UI
                print(response)

                DispatchQueue.main.async {
                    self.airportData = response 
                    self.delegate?.fetchDidSucceed()
                }
            }
        }
    }
    
    
}
