///✔
import Foundation
import MapKit

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        (annotation as? PlaceAnnotation)?.startTimer()
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "placeAnnotation")
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "placeAnnotation")
        }
        
        return annotationView
    }
}
