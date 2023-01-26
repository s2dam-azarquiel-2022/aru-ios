//
//  MyCellTableViewCell.swift
//  DarkSkySAX
//
//  Created by Usuario on 19/01/2023.
//  Copyright © 2023 Azarquiel. All rights reserved.
//

import UIKit

class CellController: UITableViewCell {

    @IBOutlet weak var tempMin: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var precipitation: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
