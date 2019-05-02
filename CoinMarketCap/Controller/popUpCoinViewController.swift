//
//  popUpCoinViewController.swift
//  CoinMarketCap
//
//  Created by Brousse guillaume on 24/05/2018.
//  Copyright © 2018 Brousse guillaume. All rights reserved.
//

import UIKit

class popUpCoinViewController: UIViewController {

    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var coinsImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var percent1hLabel: UILabel!
    @IBOutlet weak var percent24hLabel: UILabel!
    @IBOutlet weak var percent7dLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var volume24hLabel: UILabel!
    @IBOutlet weak var circulatingSupplyLabel: UILabel!
    @IBOutlet weak var maxSupplyLabel: UILabel!
    
    var coin: CoinItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = coin!.symbol
        coinsImageView.downloadedFrom(link: coin!.getLink(size: 64))
        
        rankLabel.text = "( \(String(describing: coin!.rank)) )"
        nameLabel.text = coin!.name
        
        marketCapLabel.text = formatNumber(value: coin!.quotes["USD"]!.marketCap)
        volume24hLabel.text = formatNumber(value: coin!.quotes["USD"]!.getVolume24h())
        priceLabel.text = formatNumber(value: coin!.quotes["USD"]!.price)
        
        circulatingSupplyLabel.text = formatNumber(value: coin!.getCirculatingSupply())
        maxSupplyLabel.text = formatNumber(value: coin!.getMaxSupply())
        
        percent1hLabel.text = formatNumber(value: coin!.quotes["USD"]!.percentChange1h!) + "%"
        percent24hLabel.text = formatNumber(value: coin!.quotes["USD"]!.percentChange24h!) + "%"
        percent7dLabel.text = formatNumber(value: coin!.quotes["USD"]!.percentChange7d!) + "%"
        
        //Set color si positif / negatif
        percent1hLabel.textColor = (positiveNumber(value: coin!.quotes["USD"]!.percentChange1h!) ? UIColor.green : UIColor.red)
        percent24hLabel.textColor = (positiveNumber(value: coin!.quotes["USD"]!.percentChange24h!) ? UIColor.green : UIColor.red)
        percent7dLabel.textColor = (positiveNumber(value: coin!.quotes["USD"]!.percentChange7d!) ? UIColor.green : UIColor.red)
        
        
    }

    func positiveNumber(value:Double)-> Bool{
        if(String(value).range(of:"-") == nil){
            return true
        }else{
            return false
        }
    }
    func formatNumber(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        formatter.locale = Locale(identifier: Locale.current.identifier)
        let result = formatter.string(from: value as NSNumber)
        return result!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
