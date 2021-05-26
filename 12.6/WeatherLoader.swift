

import Foundation
import Alamofire
import RealmSwift

class WeatherLoader{
    var realm = try! Realm()
    func loadCurrentWeather(completition: @escaping (CurrentWeather?) -> Void  ) {
      
        AF.request("https://api.openweathermap.org/data/2.5/weather?q=moscow&appid=3a14ad0119916c932aab1566c5d31410").responseJSON{ response in
            if let result = response.value,
               let jsonDict = result as? NSDictionary{
                let weather = CurrentWeather(data: jsonDict)
                completition(weather)
                }
            
        }
    }
    
    func load7(completition: @escaping ([Weather7]?) -> Void ) {
        AF.request("https://api.openweathermap.org/data/2.5/onecall?lat=55.45&lon=37.36&exclude=current,minutely,hourly,alerts&appid=3a14ad0119916c932aab1566c5d31410").responseJSON{ response in
            if let result = response.value,
               let jsonDict = result as? NSDictionary{
                var weatherArr: [Weather7] = []
                if let dailyArr = jsonDict["daily"] as? NSArray{
                for(data) in dailyArr where data is NSDictionary{
                    if let weather = Weather7(data: data as! NSDictionary){
                        weatherArr.append(weather)
                    }
                }
                completition(weatherArr)
                }
            }
            
        }
    
    }

    
}
