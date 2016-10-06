import UIKit
import Spots
import Brick

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var navigationController: UINavigationController?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)

    CarouselSpot.register(defaultView: GridHexCell.self)
    CarouselSpot.configure = { collectionView, _ in
      collectionView.backgroundColor = UIColor.black
    }

    let controller = SpotsController(spots: [
      CarouselSpot(Component(title: "CMYK", span: 3, items:
        [
          Item(title: "#00FFFF"),
          Item(title: "#FF00FF"),
          Item(title: "#FFFF00"),
          Item(title: "#000000")
        ]
        ), top: 5, left: 15, bottom: 5, right: 15, itemSpacing: 15),
      CarouselSpot(Component(title: "Facebook", span: 3, items:
        [
          Item(title: "#3b5998"),
          Item(title: "#8b9dc3"),
          Item(title: "#dfe3ee"),
          Item(title: "#f7f7f7"),
          Item(title: "#ffffff")
        ]
        ), top: 5, left: 15, bottom: 5, right: 15, itemSpacing: 15),
      CarouselSpot(Component(title: "Rainbow Dash", span: 3, items:
        [
          Item(title: "#ee4035"),
          Item(title: "#f37736"),
          Item(title: "#fdf498"),
          Item(title: "#7bc043"),
          Item(title: "#0392cf")
        ]
        ), top: 5, left: 15, bottom: 5, right: 15, itemSpacing: 15),
      CarouselSpot(Component(title: "Beach", span: 3, items:
        [
          Item(title: "#96ceb4"),
          Item(title: "#ffeead"),
          Item(title: "#ff6f69"),
          Item(title: "#ffcc5c"),
          Item(title: "#88d8b0")
        ]
        ), top: 5, left: 15, bottom: 5, right: 15, itemSpacing: 15),
      ]
    )

    controller.spotsScrollView.contentInset.top = 15

    window?.rootViewController = controller
    window?.makeKeyAndVisible()

    return true
  }
}

