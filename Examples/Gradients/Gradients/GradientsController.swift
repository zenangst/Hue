import Spots
import Hue
import Fakery
import Sugar

class GradientsController: SpotsController {

  static let faker = Faker()

  lazy var gradient: CAGradientLayer = [
    UIColor.hex("#FD4340"),
    UIColor.hex("#CE2BAE")
    ].gradient { gradient in
      gradient.speed = 0
      gradient.timeOffset = 0
      return gradient
  }

  lazy var animation: CABasicAnimation = { [unowned self] in
    let animation = CABasicAnimation(keyPath: "colors")
    animation.duration = 1.0
    animation.removedOnCompletion = false
    return animation
    }()

  convenience init(title: String) {
    self.init(spot: ListSpot())
    self.title = title

    spotsScrollView.backgroundColor = UIColor.clearColor()
    spotsScrollView.contentInset.bottom = 64

    animation.fromValue = gradient.colors
    animation.toValue = [
      UIColor.hex("#8D24FF").CGColor,
      UIColor.hex("#23A8F9").CGColor
    ]
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    dispatch(queue: .Interactive) { [weak self] in
      self?.update { $0.component.items = GradientsController.generateItems(0, to: 50) }
    }
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    guard let navigationController = navigationController else { return }

    navigationController.view.layer.insertSublayer(gradient, atIndex: 0)
    gradient.timeOffset = 0
    gradient.bounds = navigationController.view.bounds
    gradient.frame = navigationController.view.bounds
    gradient.addAnimation(animation, forKey: "Change Colors")
  }

  override func scrollViewDidScroll(scrollView: UIScrollView) {
    updateGradient()
  }

  func updateGradient() {
    let offset = spotsScrollView.contentOffset.y / spotsScrollView.contentSize.height

    if offset >= 0 && offset <= CGFloat(animation.duration) {
      gradient.timeOffset = CFTimeInterval(offset)
    } else if offset >= CGFloat(animation.duration) {
      gradient.timeOffset = CFTimeInterval(animation.duration)
    }

    updateNavigationBarColor()
  }

  private func updateNavigationBarColor() {
    if let navigationBar = navigationController?.navigationBar {
      if let gradientLayer = gradient.presentationLayer() as? CALayer,
        colors = gradientLayer.valueForKey("colors") as? [CGColorRef],
        firstColor = colors.first {
          navigationBar.barTintColor = UIColor(CGColor: firstColor)
      } else if let color = gradient.colors as? [CGColor],
        firstColor = color.first {
          navigationBar.barTintColor = UIColor(CGColor: firstColor)
      }
    }
  }

  static func generateItem(index: Int) -> ListItem {
    return ListItem(title: faker.lorem.sentence())
  }

  static func generateItems(from: Int, to: Int) -> [ListItem] {
    var items = [ListItem]()
    for i in from...from+to {
      autoreleasepool({
        items.append(generateItem(i))
      })
    }
    return items
  }
}
