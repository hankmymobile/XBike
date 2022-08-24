//
//  ProgressTableViewCell.swift
//  XBike
//
//  Created by Daniel Beltran on 24/08/22.
//

import UIKit

class ProgressTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var lblPointA: UILabel!
    @IBOutlet weak var lblPointB: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(route : RouteModel?){
        lblTimer.text = route?.time ?? "00:00:00"
        lblPointA.text = route?.addressA ?? ""
        lblPointB.text = route?.addressB ?? ""
        lblDistance.text = route?.distance ?? "0 Km"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
