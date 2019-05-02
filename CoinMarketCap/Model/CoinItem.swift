//
//  coinItem.swift
//  CoinMarketCap
//
//  Created by Brousse guillaume on 17/05/2018.
//  Copyright © 2018 Brousse guillaume. All rights reserved.
//

import Foundation

struct CoinItem: Codable {
    var circulatingSupply: Double?
    var id: Int
    var lastUpdated: Date
    var maxSupply: Double?
    var name: String
    var quotes: [String:Infos]
    var rank: Int
    var symbol: String
    var totalSupply: Double?
    var websiteSlug: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case symbol = "symbol"
        case rank = "rank"
        case maxSupply = "max_supply"
        case totalSupply = "total_supply"
        case circulatingSupply = "circulating_supply"
        case lastUpdated = "last_updated"
        case websiteSlug = "website_slug"
        case quotes = "quotes"
    }
    
    func getCirculatingSupply() -> Double{
        return circulatingSupply != nil ? circulatingSupply! : 0
    }
    func getMaxSupply() -> Double{
        return maxSupply != nil ? maxSupply! : 0
    }
    func getTotalSupply() -> Double{
        return totalSupply != nil ? totalSupply! : 0
    }
    func getLink(size:Int) -> String{
        return "https://s2.coinmarketcap.com/static/img/coins/"+String(size)+"x"+String(size)+"/"+String(id)+".png"
    }
}

extension CoinItem: Comparable {
    static func < (lhs: CoinItem, rhs: CoinItem) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func == (lhs: CoinItem, rhs: CoinItem) -> Bool {
        return lhs.name == rhs.name && lhs.symbol == rhs.symbol
    }
    
    static func totalCapSort(lhs: CoinItem, rhs: CoinItem) -> Bool {
        let keys = Array(lhs.quotes.keys)
        let currency = keys.first!
        return lhs.quotes[currency]!.marketCap < rhs.quotes[currency]!.marketCap
    }
    
    static func vol24hSort(lhs: CoinItem, rhs: CoinItem) -> Bool {
        let keys = Array(lhs.quotes.keys)
        let currency = keys.first!
        return rhs.quotes[currency]!.volume24h!.isLessThanOrEqualTo(lhs.quotes[currency]!.volume24h!)
    }
    
    static func priceSort(lhs: CoinItem, rhs: CoinItem) -> Bool {
        let keys = Array(lhs.quotes.keys)
        let currency = keys.first!
        return lhs.quotes[currency]!.price > rhs.quotes[currency]!.price
    }
    
    static func rankSort(lhs: CoinItem, rhs: CoinItem) -> Bool {
        return lhs.rank < rhs.rank
    }
}

struct Infos: Codable {
    
    var price: Double
    var volume24h: Double?
    var marketCap: Double
    var percentChange1h: Double?
    var percentChange24h: Double?
    var percentChange7d: Double?
    
    enum CodingKeys: String, CodingKey {
        case price = "price"
        case volume24h = "volume_24h"
        case marketCap = "market_cap"
        case percentChange1h = "percent_change_1h"
        case percentChange24h = "percent_change_24h"
        case percentChange7d = "percent_change_7d"
    }
    
    
    func getVolume24h() -> Double{
        return volume24h != nil ? volume24h! : 0
    }
}
