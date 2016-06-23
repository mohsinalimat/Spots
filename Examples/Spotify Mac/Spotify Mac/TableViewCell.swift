import Cocoa
import Spots
import Brick
import Imaginary

public class TableViewCell: NSTableRowView, SpotConfigurable {

  public var size = CGSize(width: 0, height: 88)

  public override var selected: Bool {
    didSet {
      if selected {
        layer?.backgroundColor = NSColor.blackColor().colorWithAlphaComponent(0.85).CGColor
      } else {
        layer?.backgroundColor = NSColor.blackColor().CGColor
      }
    }
  }

  lazy var imageView = NSImageView()

  lazy var titleLabel = NSTextField().then {
    $0.editable = false
    $0.selectable = false
    $0.bezeled = false
    $0.textColor = NSColor.whiteColor()
    $0.drawsBackground = false
  }

  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)

    wantsLayer = true
    layer = CALayer()
    layer?.backgroundColor = NSColor.blackColor().CGColor

    addSubview(imageView)
    addSubview(titleLabel)
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func configure(inout item: ViewModel) {
    titleLabel.frame.origin.y = 15
    titleLabel.frame.origin.x = 40
    titleLabel.stringValue = item.title
    titleLabel.sizeToFit()

    if item.image.isPresent {
      titleLabel.frame.origin.x = 40
      if item.image.hasPrefix("http") {
        imageView.frame.size.width = 40
        imageView.frame.size.height = 40
        imageView.frame.origin.y = 7.5
        imageView.setImage(NSURL(string: item.image))
      }
    }
  }
}
