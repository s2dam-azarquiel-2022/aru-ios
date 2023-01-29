//
//  OpenWeather.swift
//  DarkSkySAX
//
//  Created by Usuario on 24/01/2023.
//  Copyright © 2023 Azarquiel. All rights reserved.
//

import UIKit

class OpenWeather: UITableViewController, XMLParserDelegate {
    
    var openWeather: OpenWeatherData?
    
    private func showImage(_ urlTxt: String, _ imgView: UIImageView) {
        imgView.image = UIImage(data: (try? Data(contentsOf: URL(string: urlTxt)!))!)
    }

    private func getJsonAndDecode() {
        URLSession.shared.dataTask(with: URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=Toledo,es&APPID=601c9db344b44f9774ef76a4c07979b1&lang=sp&exclude=minutely,hourly,alerts,flags&units=metric")!) { (data, response, err) in
            guard let data = data else {return}
            do {
                self.openWeather = try JSONDecoder().decode(OpenWeatherData.self, from: data)
                self.UI()
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
        }.resume()
        
    }
    
    private func UI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJsonAndDecode()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let n = openWeather?.data!.count else { return 0 }
        return n
    }
    
    private func round(_ temp: String) -> String {
        return "\(String(format: "%.1f", Float(temp)!))°"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CellController
        let curr = (openWeather?.data![indexPath.row])!
        cell.desc.text = curr.weather![0].description
        cell.tempMax.text = round("\(curr.info!.tempMax!)")
        cell.tempMin.text = round("\(curr.info!.tempMin!)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateOrigin = dateFormatter.date(from: curr.date!)
        dateFormatter.dateFormat = "dd/MM HH:mm"
        cell.date.text = dateFormatter.string(from: dateOrigin!)
        cell.humidity.text = "\(curr.info!.humidity!)%"
        cell.windSpeed.text = "\(curr.wind!.speed!)m/s"
        cell.precipitation.text = "\(curr.precipitation! * 100)%"
        showImage("http://openweathermap.org/img/wn/\(curr.weather![0].icon!)@2x.png", cell.icon)
        return cell
    }

}
