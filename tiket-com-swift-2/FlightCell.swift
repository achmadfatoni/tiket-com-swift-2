//
//  FlightCell.swift
//  tiket-com-swift-2
//
//  Created by Achmad Fatoni on 10/30/15.
//  Copyright © 2015 Achmad Fatoni. All rights reserved.
//

import UIKit

class FlightCell: UITableViewCell {

    
    @IBOutlet weak var airlaneName: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var priceValue: UILabel!
    
    var flightId = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
