//
//  Steam.swift
//  SteamJSON
//
//  Created by Usuario on 26/01/2023.
//  Copyright © 2023 Azarquiel. All rights reserved.
//

import UIKit

class Steam: UITableViewController {

    var mainJSON: MainJSON!
    let url = "http://api.steampowered.com/ISteamApps/GetAppList/v0002/"
    
    func parse() {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                self.mainJSON = try JSONDecoder().decode(MainJSON.self, from: data)
                DispatchQueue.main.async { self.tableView.reloadData() }
            } catch let jsonErr {
                print("Error serializing JSON", jsonErr)
            }
        }.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        parse()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mainJSON = mainJSON else { return 0 }
        return (mainJSON.appList?.apps!.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainRow", for: indexPath) as! MainRow
        cell.appName.text = mainJSON?.appList?.apps![indexPath.row].name
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMainRowDetail" {
            let controllerDetail = segue.destination as! MainRowDetail
            controllerDetail.id = (mainJSON?.appList?.apps![self.tableView.indexPathForSelectedRow!.row].id)!
        }
    }

}
