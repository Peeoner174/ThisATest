///✔
import UIKit
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    let place: Place
    var delegate: PlaceAnnotationDelegate?
    var timer: Timer?
    
    init(_ place: Place, delegate: PlaceAnnotationDelegate) {
        self.place = place
        self.delegate = delegate
        coordinate = place.coordinate()
        title = place.name
        
        super.init()
    }
    
    //Запускает таймер и мониторит нуждается ли данный маркер еще в показе
    func startTimer() {
        let timeInterval = place.lifeSpanInSeconds()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] (timer) in
            timer.invalidate()
            if let safeSelf = self {
                safeSelf.delegate?.endLifeAnnotation(safeSelf)
            }
        }
    }
    
    func stopTimer() {
        delegate = nil
        timer?.invalidate()
    }
}
