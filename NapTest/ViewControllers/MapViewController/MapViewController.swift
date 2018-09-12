///✔
import UIKit
import MapKit

class MapViewController: UIViewController {
    var donateButton: UIButton!
    var mapView : MKMapView!
    var loadPlacesButton: UIBarButtonItem!

    //Серия запросов
    var placeRequestUrlChain = PlaceRequestUrlChain()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.customStatusBarColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = MKMapView()
        view = mapView
        setDonateButton()
        setNavBar()
        mapView.delegate = self
        placeRequestUrlChain.delegate = self

    }

    func setDonateButton() {
        donateButton = {
            let button = UIButton(type: UIButtonType.system)
            button.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("DONATE MONEY", for: UIControlState.normal)
            button.setTitleColor(UIColor.white, for: UIControlState.normal)
            button.backgroundColor = UIColor.customMainRedColor
            button.addTarget(self, action: #selector(donateMoney), for: .touchUpInside)
            return button
        }()
        
        //Добавление элемента в viewController
        view.addSubview(donateButton)

        let constraints:[NSLayoutConstraint] = [
            donateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            donateButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            donateButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            ]
        NSLayoutConstraint.activate(constraints)
    }

    func setNavBar()  {
        loadPlacesButton = {
            let button = UIBarButtonItem(image: #imageLiteral(resourceName: "search2"), style: .done, target: self, action: #selector(LoadPlacesPressed))
            button.tintColor = UIColor.white
            return button
        }()
        navigationItem.title = "MusicBrainz Places"
        navigationItem.rightBarButtonItem = loadPlacesButton
        navigationController?.navigationBar.backgroundColor = UIColor.customMainRedColor
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)
        ]
    }

    //Обработка нажатия на кнопку
    @objc func LoadPlacesPressed() {
        //Для каждой аннотации, которая присутствует на карте
        mapView.annotations.forEach {
            if let annotation = $0 as? PlaceAnnotation {
                annotation.startTimer()
                //Удаление аннотаций уже присутствующих на карте при нажатии на кнопку
                mapView.removeAnnotation(annotation)
            }
        }
        loadPlaces()
    }
    
    @objc func donateMoney() {
        //Собираю свой первый миллион 😏
        let url = URL(string: "https://money.yandex.ru/to/410014644526595")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    func loadPlaces() {
        placeRequestUrlChain.fetchUsing(mapView.luceneSearchCoordinateQuery(), limit: Config.queryPlacesLimit)
    }
}
