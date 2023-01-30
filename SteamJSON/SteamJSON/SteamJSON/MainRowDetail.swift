//
//  RowDetail.swift
//  SteamJSON
//
//  Created by Usuario on 26/01/2023.
//  Copyright © 2023 Azarquiel. All rights reserved.
//

import UIKit

class MainRowDetail: UIViewController {
    
    var id = 0
    var detailJSON: DetailJSON!
    let url = "http://store.steampowered.com/api/appdetails/?appids="

    func parse() {
        let id = "\(self.id)"
        guard let url = URL(string: "\(url)\(id)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                self.detailJSON = try JSONDecoder().decode(DetailJSON.self, from: data.subdata(in: (id.count + 4)..<data.count-1))
                DispatchQueue.main.async { self.paint() }
            } catch let jsonErr {
                print("Error serializing JSON", jsonErr)
            }
        }.resume()
    }

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parse()
    }
    
    private func showImage(_ urlTxt: String, _ imgView: UIImageView) {
        imgView.image = UIImage(data: (try? Data(contentsOf: URL(string: urlTxt)!))!)
    }

    
    private func paint() {
        name.text = detailJSON.data?.name
        if let gameImg = detailJSON.data?.img { showImage(gameImg, img) }
        desc.text = detailJSON.data?.desc
    }

}
