//
//  CoinsTableViewController.swift
//  CoinMarketCap
//
//  Created by Brousse guillaume on 17/05/2018.
//  Copyright © 2018 Brousse guillaume. All rights reserved.
//

import UIKit

class CoinsTableViewController: UITableViewController {
    @IBOutlet weak var CoinsTableView: UITableView!
    var marketCap = 0
    var dataSource = [CoinItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.CoinsTableView.dataSource = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        let url = URL(string: "https://api.coinmarketcap.com/v2/ticker/?limit=100")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            do {
                guard let parsedData = try JSONSerialization.jsonObject(with: data) as? [String:Any] else { return }
                let datas = try JSONSerialization.data(withJSONObject: parsedData["data"]!)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                
                for (_, value) in try decoder.decode(Dictionary<String, CoinItem>.self, from:datas){
                    self.dataSource.append(value as CoinItem)
                }
                
                DispatchQueue.main.async {
                    self.dataSource.sort(by: CoinItem.rankSort)
                    self.CoinsTableView.reloadData()
                }
            } catch let error as NSError {
                print("Error: \(error)")
            }
            }.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func orderByRank(_ sender: Any) {
        self.dataSource.sort(by: CoinItem.rankSort)
        self.CoinsTableView.reloadData()
    }
    @IBAction func orderByName(_ sender: Any) {
        self.dataSource.sort()
        self.CoinsTableView.reloadData()
    }
    @IBAction func orderByPrice(_ sender: Any) {
        self.dataSource.sort(by: CoinItem.priceSort)
        self.CoinsTableView.reloadData()
    }
    @IBAction func orderByVolume(_ sender: Any) {
        self.dataSource.sort(by: CoinItem.vol24hSort)
        self.CoinsTableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CoinsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "tvCellView") as! CoinsTableViewCell
        
        // Configure the cell...
        guard dataSource.count > indexPath.row else {
            return cell
        }
        
        cell.initCell(data: dataSource[indexPath.row])
        return cell
    }

    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //let coin = dataSource[indexPath.row]
//        // performSegue(withIdentifier: "Detailes", sender: self)
//        //performSegue(withIdentifier: "showCoinDetails", sender: nil)
//    }
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */
    
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCoinDetail"{
            guard let coinDetail = segue.destination as? popUpCoinViewController else { return }
            guard let cell = sender as? CoinsTableViewCell else {return}
            coinDetail.coin = cell.coin
        }
    }

}
