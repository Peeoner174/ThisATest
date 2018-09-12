///✔
import Foundation

//Служит для обработки ответа с сервера
protocol PlaceRequestUrlChainDelegate {
    func didFetch(places: [Place])
    func didCompleteFetching(_ error: Error?)
}
