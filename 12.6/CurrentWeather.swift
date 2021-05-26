
import Foundation
import RealmSwift

class CurrentWeather: Object{
    
    @objc dynamic var tempepature: Double = 0
    @objc dynamic var windSpeed: Double = 0
    @objc dynamic var cityName: String = ""
    
    
    
    convenience init?(data: NSDictionary) {
        self.init()
        guard  let cityName = data["name"] as? String,
               let main = data["main"] as? NSDictionary,
               let tempepature = main["temp"] as? Double,
               let wind = data["wind"] as? NSDictionary,
               let windSpeed = wind["speed"] as? Double
            else{ return nil}
        self.tempepature = tempepature
        self.windSpeed = windSpeed
        self.cityName = cityName
      
    }
    
   
}

        
