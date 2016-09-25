/**
 * Tae Won Ha - http://taewon.de - @hataewon
 * See LICENSE
 */

import Cocoa

extension NSButton {

  var boolState: Bool {
    get {
      return self.state == NSOnState ? true : false
    }

    set {
      self.state = newValue ? NSOnState : NSOffState
    }
  }
}

extension NSAttributedString {

  func draw(at point: CGPoint, angle: CGFloat) {
    let translation = NSAffineTransform()
    let rotation = NSAffineTransform()

    translation.translateXBy(point.x, yBy: point.y)
    rotation.rotateByRadians(angle)

    translation.concat()
    rotation.concat()

    self.drawAtPoint(CGPoint.zero)

    rotation.invert()
    translation.invert()

    rotation.concat()
    translation.concat()
  }

  // From https://developer.apple.com/library/mac/qa/qa1487/_index.html
  static func link(withUrl url: NSURL, text: String, font: NSFont? = nil) -> NSAttributedString {
    let attrString = NSMutableAttributedString(string: text)
    let range = NSRange(location: 0, length: attrString.length)

    attrString.beginEditing()
    if font != nil {
      attrString.addAttribute(NSFontAttributeName, value: font!, range: range)
    }
    attrString.addAttribute(NSLinkAttributeName, value: url.absoluteString, range: range)
    attrString.addAttribute(NSForegroundColorAttributeName, value: NSColor.blueColor(), range: range)
    attrString.addAttribute(NSUnderlineStyleAttributeName,
                            value: NSNumber(integer: NSUnderlineStyle.StyleSingle.rawValue), range: range)
    attrString.endEditing()

    return attrString
  }

  var wholeRange: NSRange {
    return NSRange(location: 0, length: self.length)
  }
}

extension NSView {

  func removeAllSubviews() {
    self.subviews.forEach { $0.removeFromSuperview() }
  }

  func removeAllConstraints() {
    self.removeConstraints(self.constraints)
  }
}

extension NSTableView {

  static func standardTableView() -> NSTableView {
    let tableView = NSTableView(frame: CGRect.zero)

    let column = NSTableColumn(identifier: "name")
    column.editable = false

    tableView.addTableColumn(column)
    tableView.rowSizeStyle	=	.Default
    tableView.sizeLastColumnToFit()
    tableView.allowsEmptySelection = false
    tableView.allowsMultipleSelection = false
    tableView.headerView = nil
    tableView.focusRingType = .None

    return tableView
  }

  static func standardSourceListTableView() -> NSTableView {
    let tableView = self.standardTableView()
    tableView.selectionHighlightStyle = .SourceList

    return tableView
  }
}

extension NSScrollView {

  static func standardScrollView() -> NSScrollView {
    let scrollView = NSScrollView(frame: CGRect.zero)

    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.hasVerticalScroller = true
    scrollView.hasHorizontalScroller = true
    scrollView.autohidesScrollers = true
    scrollView.borderType = .BezelBorder

    return scrollView
  }
}