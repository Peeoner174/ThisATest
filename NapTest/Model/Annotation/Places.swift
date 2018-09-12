///✔
import Foundation

//Хранит массив координат маркеров на карте, их общее колличество и положение курсора(шаг смещения в count`e маркеров)
struct Places: Codable {
    let count: Int?
    let offset: Int
    let places: [Place]
    
    let maxCount = Config.maxCount
    
    //Лимит определяет какое максимальное колличество places может быть возвращенно в одном запросе, nextOffsetFor - возвращает текущую позицию курсора в массиве places
    func nextOffsetFor(_ limit: Int) -> Int? {
        let nextOffset = limit + offset
        if (nextOffset >= maxCount) || (nextOffset >= count ?? 0) {
            return nil
        }
        return nextOffset
    }
}

