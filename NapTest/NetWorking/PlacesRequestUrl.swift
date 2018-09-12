///✔
import Foundation

enum PlacesRequestUrl {
    case place(query: String, offset: Int, limit: Int)
    
    private static let kURL = "https://musicbrainz.org/ws/2/"
    
    //Формирование url
    func url() -> URL? {
        switch self {
        case .place(let query, let offset, let limit):
            //Конфигурирует запрос диапозоном годов открытия места и границами местоположения
            let q = "begin:[\(Config.openPlacesFromYears) TO 2018] AND \(query)"
            guard let escapedQuery = q.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return nil }
            
            let string = "\(PlacesRequestUrl.kURL)place/?query=\(escapedQuery)&fmt=json&offset=\(offset)&limit=\(limit)"
            
            return URL(string: string)
        }
    }
}


