import UIKit
import Spots

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var navigationController: UINavigationController?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)

    ListSpot.configure = { tableView in
      tableView.backgroundColor = UIColor.clear
      tableView.tableFooterView = UIView(frame: CGRect.zero)
      tableView.separatorInset = UIEdgeInsets(top: 10,
        left: 10,
        bottom: 10,
        right: 10)
      tableView.separatorColor = Color.cellSeparator
    }
    ListSpot.register(defaultView: GradientListCell.self)

    let controller = GradientsController(title: "Gradients")
    let navigationController = UINavigationController(rootViewController: controller)

    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()

    applyStyles()

    return true
  }

  fileprivate func applyStyles() {
    let navigationBar = UINavigationBar.appearance()
    navigationBar.barStyle = .black
    navigationBar.isTranslucent = false
    navigationBar.titleTextAttributes = [
      NSForegroundColorAttributeName: Color.navigationBarForeground,
      NSFontAttributeName: Font.navigationBar
    ]
    navigationBar.tintColor = Color.navigationBarForeground
    navigationBar.barTintColor = UIColor(red:0.333, green:0.220, blue:0.478, alpha: 1)
    navigationBar.shadowImage = UIImage()
  }
}

