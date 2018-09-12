///✔
import Foundation
import MapKit

//Хранит информацию о месте
struct Place: Codable {
    let name: String
    var coordinates: Coordinates
    let lifeSpan: LifeSpan
    
    //Поля JSON 
    private enum CodingKeys : String, CodingKey {
        case name, coordinates, lifeSpan = "life-span"
    }
    
    //Координаты места
    func coordinate() -> CLLocationCoordinate2D {
        guard
            let lat = CLLocationDegrees(coordinates.latitude),
            let lon = CLLocationDegrees(coordinates.longitude) else {
                return CLLocationCoordinate2D()
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    //Возвращает время жизни маркера (время создания places - 1990)
    func lifeSpanInSeconds() -> TimeInterval {
        let years = Calendar.current.component(.year, from: lifeSpan.begin)
        return TimeInterval(years - Config.openPlacesFromYears)
    }
}
