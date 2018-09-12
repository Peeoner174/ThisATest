///✔
import Foundation

//Удаление с карты маркеров, чья жизнь завершилась
protocol PlaceAnnotationDelegate {
    func endLifeAnnotation(_ annotation: PlaceAnnotation)
}
