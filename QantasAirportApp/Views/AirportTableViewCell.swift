//
//  AirportTableViewCell.swift
//  QantasAirportApp
//
//  Created by sonam taya on 10/1/22.
//

import UIKit

class AirportTableViewCell: UITableViewCell {

    // MARK: - Variables and Properties

    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCountry: UILabel!

    func configureCell(with AirportData: Airport) {
        labelName.text = AirportData.airportName
        labelCountry.text = "Country: \(AirportData.country.countryName)"
      
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
