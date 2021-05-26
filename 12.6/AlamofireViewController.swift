//
//  AlamofireViewController.swift
//  12.6
//
//  Created by user on 19.05.21.
//

import UIKit
import RealmSwift

class AlamofireViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tempLable: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var windLable: UILabel!
    var weather: CurrentWeather?
    var weather7: [Weather7] = []
    var realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.endEditing(true)
        loadCurrentFromRealm()
        load7FromRealm()
        WeatherLoader().loadCurrentWeather { weather in
            self.weather = weather
           
            try! self.realm.write{
                let allWeather = self.realm.objects(CurrentWeather.self)
                self.realm.delete(allWeather)
                if let w = self.weather{
                self.realm.add(w)
                }
            self.tempLable.text = String( weather?.tempepature ?? 0)
            self.windLable.text = String( weather?.windSpeed ?? 0)
            self.nameLable.text = weather?.cityName
            }
        }
        WeatherLoader().load7{ weatherArr in
            self.weather7 = []
            self.weather7 = weatherArr ?? self.weather7
            try! self.realm.write{
                let allWeather = self.realm.objects(Weather7.self)
                self.realm.delete(allWeather)
                self.realm.add(self.weather7)
            }
            self.tableView.reloadData()
        }
    }
    func loadCurrentFromRealm() {
        let cw = realm.objects(CurrentWeather.self).last
        self.tempLable.text = String( cw?.tempepature ?? 0)
        self.windLable.text = String( cw?.windSpeed ?? 0)
        self.nameLable.text = cw?.cityName
        
    }
    func load7FromRealm() {
        let weatherList = realm.objects(Weather7.self)
        for w in weatherList{
            weather7.append(w)
        }
    
    }
 
}
extension AlamofireViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather7.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Alamo") as! WeatherCell
        let weather = weather7[indexPath.row]
        cell.dateLabel.text = weather.date
        cell.tempLabel.text = String(weather.tempepature)
        cell.windLabel.text = String(weather.windSpeed)
        return cell
        
    }
 
   
}
