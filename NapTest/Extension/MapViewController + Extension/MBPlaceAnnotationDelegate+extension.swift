///✔
import Foundation

extension MapViewController: PlaceAnnotationDelegate {
    //Удаление аннотации с карты
    func endLifeAnnotation(_ annotation: PlaceAnnotation) {
        let filtered = mapView.annotations.filter { ($0 as? PlaceAnnotation) == annotation }
        mapView.removeAnnotations(filtered)
    }
}
