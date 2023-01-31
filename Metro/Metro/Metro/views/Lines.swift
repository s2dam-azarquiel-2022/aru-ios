//
//  Lines.swift
//  Metro
//
//  Created by Usuario on 31/01/2023.
//  Copyright © 2023 Azarquiel. All rights reserved.
//

import UIKit

class Lines: UITableViewController {
    
    var lines = [Line]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lines = DaoManager.getInstance().getLineas()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lines.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lineRowID", for: indexPath) as! LineRow
        cell.name.text = lines[indexPath.row].name
        cell.startEnd.text = lines[indexPath.row].startEnd
        cell.img.image = UIImage(named: "icono_linea_\(lines[indexPath.row].id)")
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
