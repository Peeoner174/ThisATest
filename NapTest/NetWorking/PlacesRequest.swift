///✔
import UIKit

enum NetworkError: Int {
    case corruptedUrl
    case unknownNetworkError
    case jsonDecodingError
    
    static let kDomain = "com.musicbrainz.networkError"
    
    var error: NSError { get { return NSError(domain: NetworkError.kDomain, code: self.rawValue, userInfo: nil) } }
}

//Запрос в сеть и декодирование респонса
class PlacesRequest: NSObject {
    var endpoint: PlacesRequestUrl?
    var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = .shared
        
        super.init()
    }
    
    init(endpoint: PlacesRequestUrl, session: URLSession? = .shared) {
        self.endpoint = endpoint
        self.session = session ?? .shared
        
        super.init()
    }

    func execute(onSuccess: @escaping (Data) -> (), onError: @escaping (Error) -> ()) {
        guard let url = endpoint?.url() else {
            onError(NetworkError.corruptedUrl.error)
            return
        }
        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            if let data = data {
                onSuccess(data)
            }
            else {
                onError(error ?? NetworkError.unknownNetworkError.error)
            }
        }
        
        task.resume()
    }
    
    func execute<T>(_ type: T.Type, onSuccess: @escaping (T) -> (), onError: @escaping (Error) -> ()) where T : Codable {
        execute(onSuccess: { (data) in
            do {
                let result = try JSONDecoder().decode(type, from: data)
                onSuccess(result)
            } catch let error {
                onError(error)
            }
        }, onError: { onError($0) })
    }
}
