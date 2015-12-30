import UIKit
import Spots
import Hue

class GradientListCell: ListSpotCell {

  lazy var selectedView: UIView = {
    let view = UIView()
    view.backgroundColor = Color.cellSelectedColor

    return view
  }()

  override func configure(inout item: ListItem) {
    textLabel?.textColor = UIColor.hex("#fff").alpha(0.8)
    textLabel?.text = item.title
    textLabel?.font = Font.cell
    selectedBackgroundView = selectedView
    backgroundColor = UIColor.clearColor()

    item.size = CGSize(width: 64, height: 64)
  }
}
