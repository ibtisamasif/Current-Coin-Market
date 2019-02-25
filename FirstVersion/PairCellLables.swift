//
//  PairCellLables.swift
//  FirstVersion
//
//  Created by Touqeer Ahmad on 2/13/18.
//  Copyright © 2018 Touqeer Ahmad. All rights reserved.
//

import UIKit

class PairCellLables: UITableViewCell {
    
    @IBOutlet weak var lbPercent1H: UILabel!
    @IBOutlet weak var lbPercent24h: UILabel!
    @IBOutlet weak var lbPriceUsd: UILabel!
    @IBOutlet weak var lbPriceBtc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
