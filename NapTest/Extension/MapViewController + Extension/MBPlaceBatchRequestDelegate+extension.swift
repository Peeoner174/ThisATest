///✔
import Foundation
import UIKit

//Добавление аннотаций на View
extension MapViewController: PlaceRequestUrlChainDelegate {
    
    //Добавление маркеров из массива на карту
    func didFetch(places: [Place]) {
        DispatchQueue.main.async {
            places.forEach {
            self.mapView.addAnnotation(PlaceAnnotation($0, delegate: self))
            }
        }
    }
    
    //Обработка ошибок при нажатию на кнопку
    func didCompleteFetching(_ error: Error?) {
        DispatchQueue.main.async {
            
            if let error = error {
                let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
