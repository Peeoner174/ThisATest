///✔
import Foundation
import MapKit

typealias Edges = (ne: CLLocationCoordinate2D, sw: CLLocationCoordinate2D)

extension MKMapView {
    //Зона, которая в данный момент отображается на карте в смартфоне(две крайние точки, которые образуют диагональ области)
    func edgeCoordinates() -> Edges {
        let nePoint = CGPoint(x: self.bounds.maxX, y: self.bounds.origin.y)
        let swPoint = CGPoint(x: self.bounds.minX, y: self.bounds.maxY)
        let neCoord = self.convert(nePoint, toCoordinateFrom: self)
        let swCoord = self.convert(swPoint, toCoordinateFrom: self)
        return (ne: neCoord, sw: swCoord)
    }
    
    //С помощью edgeCoordinates вычисляется область которую в данный момент пользователь видит на карте
    func luceneSearchCoordinateQuery() -> String {
        let edge = edgeCoordinates()
        let result = """
            lat:[\(edge.sw.latitude) TO \(edge.ne.latitude)] AND
            long:[\(edge.sw.longitude) TO \(edge.ne.longitude)]
        """
        return result
    }
}
