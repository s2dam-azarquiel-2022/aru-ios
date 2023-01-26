//
//  OpenWeather.swift
//  DarkSkySAX
//
//  Created by Usuario on 24/01/2023.
//  Copyright © 2023 Azarquiel. All rights reserved.
//

import UIKit

class OpenWeather: UITableViewController, XMLParserDelegate {
    
    var parser = XMLParser()
    var times = [[String:String]]()
    var curr = [String:String]()
    
    func parser(_ parses: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String]) {
        switch elementName {
        case "time":
            curr = [String:String]()
            curr["date"] = attributeDict["from"]
        case "symbol":
            curr["desc"] = attributeDict["name"]
            curr["icon"] = attributeDict["var"]
        case "precipitation":
            curr["precipitation"] = attributeDict["probability"]
        case "windSpeed":
            curr["windSpeed"] = attributeDict["mps"]
        case "temperature":
            curr["tempMin"] = attributeDict["min"]
            curr["tempMax"] = attributeDict["max"]
        case "humidity":
            curr["humidity"] = attributeDict["value"]
        default: return
        }
    }
    
    private func showImage(_ urlTxt: String, _ imgView: UIImageView) {
        imgView.image = UIImage(data: (try? Data(contentsOf: URL(string: urlTxt)!))!)
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case "time":
            times.append(curr)
        default: return
        }
    }


    private func getParser() {
        parser = XMLParser(contentsOf: URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=Toledo,es&mode=xml&APPID=601c9db344b44f9774ef76a4c07979b1&lang=sp&exclude=minutely,hourly,alerts,flags&units=metric")!)!
        parser.delegate = self
        parser.parse()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getParser()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }
    
    private func round(_ temp: String) -> String {
        return "\(String(format: "%.1f", Float(temp)!))°"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CellController
        let curr = times[indexPath.row]
        cell.desc.text = curr["desc"]
        cell.tempMax.text = round(curr["tempMax"]!)
        cell.tempMin.text = round(curr["tempMin"]!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateOrigin = dateFormatter.date(from: curr["date"]!)
        dateFormatter.dateFormat = "dd/MM HH:mm"
        cell.date.text = dateFormatter.string(from: dateOrigin!)
        cell.humidity.text = "\(curr["humidity"]!)%"
        cell.windSpeed.text = "\(curr["windSpeed"]!)m/s"
        cell.precipitation.text = "\(curr["precipitation"]!)%"
        showImage("http://openweathermap.org/img/wn/\(curr["icon"]!)@2x.png", cell.icon)
        return cell
    }

}
