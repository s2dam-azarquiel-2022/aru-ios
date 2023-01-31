//
//  LineRow.swift
//  Metro
//
//  Created by Usuario on 31/01/2023.
//  Copyright © 2023 Azarquiel. All rights reserved.
//

import UIKit

class LineRow: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var startEnd: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
