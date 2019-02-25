//
//  CoinCellLables.swift
//  FirstVersion
//
//  Created by Touqeer Ahmad on 2/12/18.
//  Copyright © 2018 Touqeer Ahmad. All rights reserved.
//

import UIKit

class CoinCellLables: UITableViewCell {
    
    @IBOutlet weak var lbCoinPriceUsd: UILabel!
    @IBOutlet weak var lbCoinRank: UILabel!
    @IBOutlet weak var lbCoinSymbol: UILabel!
    @IBOutlet weak var lbCoinName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
