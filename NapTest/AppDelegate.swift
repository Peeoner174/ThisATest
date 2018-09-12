///✔
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        //Так как StoryBoard не используется, нужно задать window для отображения
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let navController = UINavigationController(rootViewController: MapViewController())

        window?.rootViewController = navController

        UINavigationBar.appearance().shadowImage = UIImage()
        //NavigatiomBar больше не закрывает половину HeadView
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)

        return true
    }

 }


