//
//  AirportDetailViewController.swift
//  QantasAirportApp
//
//  Created by sonam taya on 10/1/22.
//

import UIKit

class AirportDetailViewController: UIViewController {
    
    // MARK: - Variables and Properties
    var airportData: Airport?
    
    // MARK: - Subviews
    
    let loadingView: IndicatorLoadingView = {
        let view = IndicatorLoadingView()
        return view
    }()
    
    let customView = AirportDetailView()
    
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        [customView, loadingView].forEach { view.addSubview($0) }
        setupLayouts()
    }
    
    private func setupLayouts() {
        customView.constraints(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        loadingView.constraints(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        customView.labelCountry.text = "Country: \(airportData?.country.countryName ?? "")"
        customView.labelLocation.text = "Location: \(airportData?.country.countryName ?? ""),\(airportData?.region.regionName ?? "")(\(airportData?.location.latitude ?? 0), \(airportData?.location.longitude ?? 0))"
        customView.labelTimeZone.text = "TimeZone: \(airportData?.city.timeZoneName ?? "")"

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = airportData?.airportName
        loadingView.removeFromSuperview()
    }
    
}
