///✔
import Foundation

struct LifeSpan: Codable {
    //Хранит дату открытия места
    let begin: Date
    
    //Декодирование даты из JSON в объект Date
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let dateString = try container.decode(String.self, forKey: .begin)
        
        //Сервер может вернуть информацию о дате создания в трех разных форматах
        if let date = DateFormatter.yyyyMMdd.date(from: dateString) {
            begin = date
        } else if let date = DateFormatter.yyyy.date(from: dateString) {
            begin = date
        } else if let date = DateFormatter.yyyyMM.date(from: dateString) {
            begin = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .begin,
                                                   in: container,
                                                   debugDescription: "Date string does not match format expected by formatter.")
        }
    }
}

