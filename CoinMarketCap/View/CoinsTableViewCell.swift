//
//  CoinsTableViewCell.swift
//  CoinMarketCap
//
//  Created by Brousse guillaume on 18/05/2018.
//  Copyright © 2018 Brousse guillaume. All rights reserved.
//

import UIKit

class CoinsTableViewCell: UITableViewCell {
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var coinsImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    var coin: CoinItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initCell(data:CoinItem){
        coin = data
        rankLabel.text = "#\(data.rank)"
        nameLabel.text = data.name
        symbolLabel.text = data.symbol
        priceLabel.text = String(describing: data.quotes["USD"]!.price)
        percentLabel.text = String(describing: data.quotes["USD"]!.percentChange24h!) + "%"
        coinsImageView.downloadedFrom(link: data.getLink(size: 32))
        
        
    }
}
