import UIKit
import Spots

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var navigationController: UINavigationController?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    window = UIWindow(frame: UIScreen.mainScreen().bounds)

    ListSpot.configure = { tableView in tableView.tableFooterView = UIView(frame: CGRect.zero) }

    CarouselSpot.defaultView = GridHexCell.self

    let controller = SpotsController(spots: [
      ListSpot(title: "CMYK"),
      CarouselSpot(Component(title: "CMYK", span: 3, items:
        [
          ViewModel(title: "#00FFFF"),
          ViewModel(title: "#FF00FF"),
          ViewModel(title: "#FFFF00"),
          ViewModel(title: "#000000")
        ]
        ), top: 5, left: 15, bottom: 5, right: 15, itemSpacing: 15),
      ListSpot(title: "Facebook"),
      CarouselSpot(Component(title: "Facebook", span: 3, items:
        [
          ViewModel(title: "#3b5998"),
          ViewModel(title: "#8b9dc3"),
          ViewModel(title: "#dfe3ee"),
          ViewModel(title: "#f7f7f7"),
          ViewModel(title: "#ffffff")
        ]
        ), top: 5, left: 15, bottom: 5, right: 15, itemSpacing: 15),
      ListSpot(title: "Rainbow Dash"),
      CarouselSpot(Component(title: "Rainbow Dash", span: 3, items:
        [
          ViewModel(title: "#ee4035"),
          ViewModel(title: "#f37736"),
          ViewModel(title: "#fdf498"),
          ViewModel(title: "#7bc043"),
          ViewModel(title: "#0392cf")
        ]
        ), top: 5, left: 15, bottom: 5, right: 15, itemSpacing: 15),

      ListSpot(title: "Beach"),
      CarouselSpot(Component(title: "Beach", span: 3, items:
        [
          ViewModel(title: "#96ceb4"),
          ViewModel(title: "#ffeead"),
          ViewModel(title: "#ff6f69"),
          ViewModel(title: "#ffcc5c"),
          ViewModel(title: "#88d8b0")
        ]
        ), top: 5, left: 15, bottom: 5, right: 15, itemSpacing: 15),
      ]
    )

    window?.rootViewController = controller
    window?.makeKeyAndVisible()

    return true
  }
}

