//
//  AirportListViewController.swift
//  QantasAirportApp
//
//  Created by sonam taya on 10/1/22.
//

import UIKit

class AirportListViewController: UIViewController {
    
    // MARK: - Variables and Properties
    
    private var viewModel: AirportViewModel?
    private let refreshControl = UIRefreshControl()

    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = AirportViewModel(delegate: self)
        viewModel?.fetchAirports(with: URL(string: "\(baseUrlString)")!)
        setupViews()
        
    }
    
    // MARK: - Subviews
    
    let loadingView: IndicatorLoadingView = {
        let view = IndicatorLoadingView()
        return view
    }()

    lazy var tableView: UITableView = {
        let table = UITableView()
        // Add Refresh Control to Table View
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing please wait ...", attributes: attributes)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            table.refreshControl = refreshControl
        } else {
            table.addSubview(refreshControl)
        }
        return table
    }()
    
    // MARK: - Setup
    
    private func setupViews() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.backButtonTitle = ""
        navigationItem.title = "Airports"
        [tableView, loadingView].forEach { view.addSubview($0) }

        setupLayouts()
    }
    
    private func setupLayouts() {
        tableView.constraints(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        loadingView.constraints(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        setupTableView()
    }
    
     func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(AirportTableViewCell.nib, forCellReuseIdentifier: AirportTableViewCell.reuseIdentifier)
    }
    
    @objc private func refreshData(_ sender: Any) {
        viewModel?.fetchAirports(with: URL(string: "\(baseUrlString)")!)
    }
    


}

// MARK: - EXTENSION Tableview datasource and delegates

extension AirportListViewController : UITableViewDelegate,UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.airportData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AirportTableViewCell.reuseIdentifier, for: indexPath) as? AirportTableViewCell else { fatalError("Error dequeuing AstronautsTableViewCell") }
        if let info = viewModel?.airportData?[indexPath.row] {
            cell.configureCell(with: info)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = AirportDetailViewController()
        if let info = viewModel?.airportData?[indexPath.row] {
            viewController.airportData = info
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - EXTENSION ViewModelDelegates

extension AirportListViewController : ViewModelDelegate {
    func fetchDidSucceed() {
        print("SUCCEED*********************", self.viewModel?.airportData?.count ?? 0)
        tableView.reloadData()
        self.refreshControl.endRefreshing()
        loadingView.removeFromSuperview()
    }
    
    func fetchDidFail(with title: String, description: String) {
        print("failure******************", title,description)
        showAlert(withTitle:title, withMessage: description)
        viewModel?.airportData = nil
        tableView.reloadData()
        self.refreshControl.endRefreshing()
        loadingView.removeFromSuperview()
    }
    
}
