import Spots
import Hue
import Fakery
import Sugar
import Brick

class GradientsController: SpotsController {

  static let faker = Faker()

  lazy var gradient: CAGradientLayer = [
    UIColor(hex:"#FD4340"),
    UIColor(hex:"#CE2BAE")
    ].gradient { gradient in
      gradient.speed = 0
      gradient.timeOffset = 0

      return gradient
  }

  lazy var animation: CABasicAnimation = { [unowned self] in
    let animation = CABasicAnimation(keyPath: "colors")
    animation.duration = 1.0
    animation.isRemovedOnCompletion = false

    return animation
    }()

  convenience init(title: String) {
    self.init(spot: ListSpot())
    self.title = title

    animation.fromValue = gradient.colors
    animation.toValue = [
      UIColor(hex:"#8D24FF").cgColor,
      UIColor(hex:"#23A8F9").cgColor
    ]
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    spotsScrollView.backgroundColor = UIColor.clear
    spotsScrollView.contentInset.bottom = 64

    dispatch(queue: .interactive) { [weak self] in
      self?.update { $0.component.items = GradientsController.generateItems(0, to: 50) }
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    guard let navigationController = navigationController else { return }

    navigationController.view.layer.insertSublayer(gradient, at: 0)
    gradient.timeOffset = 0
    gradient.bounds = navigationController.view.bounds
    gradient.frame = navigationController.view.bounds
    gradient.add(animation, forKey: "Change Colors")
  }

  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    updateGradient()
  }

  fileprivate func updateGradient() {
    let offset = spotsScrollView.contentOffset.y / spotsScrollView.contentSize.height

    if offset >= 0 && offset <= CGFloat(animation.duration) {
      gradient.timeOffset = CFTimeInterval(offset)
    } else if offset >= CGFloat(animation.duration) {
      gradient.timeOffset = CFTimeInterval(animation.duration)
    }

    updateNavigationBarColor()
  }

  fileprivate func updateNavigationBarColor() {
    guard let navigationBar = navigationController?.navigationBar else { return }

    if let gradientLayer = gradient.presentation(),
      let colors = gradientLayer.value(forKey: "colors") as? [CGColor],
      let firstColor = colors.first {
        navigationBar.barTintColor = UIColor(cgColor: firstColor)
    } else if let color = gradient.colors as? [CGColor],
      let firstColor = color.first {
        navigationBar.barTintColor = UIColor(cgColor: firstColor)
    }
  }

  static func generateItem(_ index: Int) -> Item {
    return Item(title: faker.lorem.sentence())
  }

  static func generateItems(_ from: Int, to: Int) -> [Item] {
    var items = [Item]()
    for i in from...from+to {
      autoreleasepool(invoking: { items.append(generateItem(i)) })
    }
    return items
  }
}
