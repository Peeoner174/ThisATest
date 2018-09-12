///✔
import UIKit

//Формирование цепочки запросов в зависимости от колличество объектов, которые должны быть отображенны и их поочередное исполнение
class PlaceRequestUrlChain: NSObject {
    var session: URLSession?
    var delegate: PlaceRequestUrlChainDelegate?
    func fetchUsing(_ query: String, limit: Int, offset: Int = 0) {
        let endpoint = PlacesRequestUrl.place(query: query, offset: offset, limit: limit)
        
        let request = PlacesRequest(endpoint: endpoint, session: session)
        request.execute(Places.self, onSuccess: { [weak self] (places) in
            self?.delegate?.didFetch(places: places.places)
            //Формируется цепочка запросов по offset limit
            if let nextOffset = places.nextOffsetFor(limit) {
                self?.fetchUsing(query, limit: limit, offset: nextOffset)
            }
            else {
                self?.delegate?.didCompleteFetching(nil)
            }
        }, onError: { [weak self] (error) in
            self?.delegate?.didCompleteFetching(error)
        })
    }
}



