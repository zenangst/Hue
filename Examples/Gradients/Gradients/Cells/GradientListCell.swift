import UIKit
import Spots
import Hue

class GradientListCell: ListSpotCell {

  override func configure(inout item: ListItem) {
    backgroundColor = UIColor.clearColor()
    textLabel?.font = Font.cell
    textLabel?.text = item.title
    textLabel?.textColor = UIColor.hex("#fff").alpha(0.8)

    item.size = CGSize(width: 64, height: 64)
  }
}
