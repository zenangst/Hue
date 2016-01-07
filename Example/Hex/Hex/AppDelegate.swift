import UIKit
import Spots

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var navigationController: UINavigationController?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    window = UIWindow(frame: UIScreen.mainScreen().bounds)

    ListSpot.configure = { tableView in tableView.tableFooterView = UIView(frame: CGRect.zero) }

    CarouselSpot.defaultCell = GridHexCell.self

    let controller = SpotsController(spots: [
      ListSpot(title: "CMYK"),
      CarouselSpot(Component(title: "CMYK", span: 3, items:
        [
          ListItem(title: "#00FFFF"),
          ListItem(title: "#FF00FF"),
          ListItem(title: "#FFFF00"),
          ListItem(title: "#000000")
        ]
        ), top: 5, left: 15, bottom: 5, right: 15, itemSpacing: 15),
      ListSpot(title: "Facebook"),
      CarouselSpot(Component(title: "Facebook", span: 3, items:
        [
          ListItem(title: "#3b5998"),
          ListItem(title: "#8b9dc3"),
          ListItem(title: "#dfe3ee"),
          ListItem(title: "#f7f7f7"),
          ListItem(title: "#ffffff")
        ]
        ), top: 5, left: 15, bottom: 5, right: 15, itemSpacing: 15),
      ListSpot(title: "Rainbow Dash"),
      CarouselSpot(Component(title: "Rainbow Dash", span: 3, items:
        [
          ListItem(title: "#ee4035"),
          ListItem(title: "#f37736"),
          ListItem(title: "#fdf498"),
          ListItem(title: "#7bc043"),
          ListItem(title: "#0392cf")
        ]
        ), top: 5, left: 15, bottom: 5, right: 15, itemSpacing: 15),

      ListSpot(title: "Beach"),
      CarouselSpot(Component(title: "Beach", span: 3, items:
        [
          ListItem(title: "#96ceb4"),
          ListItem(title: "#ffeead"),
          ListItem(title: "#ff6f69"),
          ListItem(title: "#ffcc5c"),
          ListItem(title: "#88d8b0")
        ]
        ), top: 5, left: 15, bottom: 5, right: 15, itemSpacing: 15),
      ]
    )

    window?.rootViewController = controller
    window?.makeKeyAndVisible()

    return true
  }
}

