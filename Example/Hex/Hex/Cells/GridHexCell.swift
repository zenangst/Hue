import UIKit
import Sugar
import Spots
import Brick
import Hue

class GridHexCell: UICollectionViewCell, SpotConfigurable {

  var preferredViewSize: CGSize = CGSize(width: 125, height: 160)

  lazy var label: UILabel = { [unowned self] in
    let label = UILabel(frame: CGRect.zero)
    label.font = UIFont.boldSystemFont(ofSize: 11)
    label.numberOfLines = 4
    label.textAlignment = .center

    return label
    }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(label)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(_ item: inout Item) {
    let color = UIColor(hex:item.title)
    backgroundColor = color

    label.textColor = color.isDark ? UIColor.white : UIColor.darkGray
    label.attributedText = NSAttributedString(string: item.title,
      attributes: nil)
    label.frame.size.height = 44
    label.frame.size.width = contentView.frame.size.width - 7.5

    item.size.height = 155
  }
}
