import UIKit
import Spots

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var navigationController: UINavigationController?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)

    Configuration.registerDefault(view: GridHexCell.self)
    Component.configure = {
      $0.collectionView?.backgroundColor = UIColor.black
    }

    let layout = Layout(span: 3,
                        inset: Inset(top: 5, left: 15, bottom: 15, right: 15))

    let componentModels: [ComponentModel] = [
      ComponentModel(kind: .carousel, layout: layout, items: [
        Item(title: "#00FFFF"),
        Item(title: "#FF00FF"),
        Item(title: "#FFFF00"),
        Item(title: "#000000")
      ]),
      ComponentModel(kind: .carousel, layout: layout, items: [
        Item(title: "#3b5998"),
        Item(title: "#8b9dc3"),
        Item(title: "#dfe3ee"),
        Item(title: "#f7f7f7"),
        Item(title: "#ffffff")
      ]),
      ComponentModel(kind: .carousel, layout: layout, items: [
        Item(title: "#ee4035"),
        Item(title: "#f37736"),
        Item(title: "#fdf498"),
        Item(title: "#7bc043"),
        Item(title: "#0392cf")
      ]),
      ComponentModel(kind: .carousel, layout: layout, items: [
        Item(title: "#96ceb4"),
        Item(title: "#ffeead"),
        Item(title: "#ff6f69"),
        Item(title: "#ffcc5c"),
        Item(title: "#88d8b0")
      ]),
    ]

    let components = componentModels.map { Component(model: $0) }
    let controller = SpotsController(components: components)

    controller.scrollView.contentInset.top = 15

    window?.rootViewController = controller
    window?.makeKeyAndVisible()

    return true
  }
}

