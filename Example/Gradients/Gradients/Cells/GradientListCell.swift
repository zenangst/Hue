import UIKit
import Spots
import Hue

class GradientListCell: UITableViewCell, ItemConfigurable {

  lazy var selectedView: UIView = {
    let view = UIView()
    view.backgroundColor = Color.cellSelectedColor

    return view
  }()

  func configure(with item: Item) {
    textLabel?.textColor = UIColor(hex:"#fff").alpha(0.8)
    textLabel?.text = item.title
    textLabel?.font = Font.cell
    selectedBackgroundView = selectedView
    backgroundColor = UIColor.clear
  }

  func computeSize(for item: Item) -> CGSize {
    return CGSize(width: 64, height: 64)
  }
}
