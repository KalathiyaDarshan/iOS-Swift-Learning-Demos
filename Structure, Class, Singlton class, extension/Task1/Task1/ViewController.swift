//
//  ViewController.swift
//  Task1
//
//  Created by Mayur Mori on 13/05/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtHumidity: UITextField!
    @IBOutlet weak var txtTemperature: UITextField!
    @IBOutlet weak var txtWeather: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     }

    @IBAction func onbtnSubmit(_ sender: Any) {
        var manag = WeatherManager.weathermanag
        manag.newweatherdata(wea: txtWeather.text ?? "", temp: txtTemperature.text ?? "", hum: txtHumidity.text ?? "")
        manag.weath.temerature?.Cels()
    }
    
}

struct WeatherData{
    var weather: String?
    var temerature: String?
    var humidity: Int?

}

class WeatherManager{
    
    static let weathermanag = WeatherManager()
    var weath = WeatherData()
    
    func  newweatherdata(wea : String , temp: String, hum: String){
        weath.weather = wea
        weath.temerature = temp
        weath.humidity = Int(hum)
        
        print("Weather: \(wea ) Temperature: \(temp )° Humidity: \(hum )%")
        
    }
}

extension String{
    func Cels(){
        var manag1 = WeatherManager.weathermanag
        var cel = Int(manag1.weath.temerature ?? "")
        let decimalValue = Decimal(cel ?? Int(0.0))
        print("Decimal value:", decimalValue)

        }
}
