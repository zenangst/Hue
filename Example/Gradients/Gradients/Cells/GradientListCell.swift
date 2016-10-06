import UIKit
import Spots
import Hue
import Brick

class GradientListCell: ListSpotCell {

  lazy var selectedView: UIView = {
    let view = UIView()
    view.backgroundColor = Color.cellSelectedColor

    return view
  }()

  override func configure(_ item: inout Item) {
    textLabel?.textColor = UIColor(hex:"#fff").alpha(0.8)
    textLabel?.text = item.title
    textLabel?.font = Font.cell
    selectedBackgroundView = selectedView
    backgroundColor = UIColor.clear

    item.size = CGSize(width: 64, height: 64)
  }
}
