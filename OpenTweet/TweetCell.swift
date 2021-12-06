//
//  TweetCell.swift
//  OpenTweet
//
//  Created by Andrew Lvovsky on 12/4/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

/// A reusable UICollectionView cell to display a Tweet model's properties.
final class TweetCell: UICollectionViewCell {

  static let reuseIdentifier = "tweet-cell-reuseidentifier"

  let authorLabel = UILabel()
  let contentLabel = UILabel()
  let dateLabel = UILabel()
  let avatarImageView = UIImageView()
  let barView = UIView()

  var showsBar = true {
    didSet {
      updateBar()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configure() {
    authorLabel.translatesAutoresizingMaskIntoConstraints = false
    contentLabel.translatesAutoresizingMaskIntoConstraints = false
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    barView.translatesAutoresizingMaskIntoConstraints = false

    authorLabel.adjustsFontForContentSizeCategory = true
    contentLabel.adjustsFontForContentSizeCategory = true
    dateLabel.adjustsFontForContentSizeCategory = true

    authorLabel.numberOfLines = 0
    contentLabel.numberOfLines = 0
    dateLabel.numberOfLines = 0

    authorLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
    contentLabel.font = UIFont.preferredFont(forTextStyle: .body)
    dateLabel.font = UIFont.preferredFont(forTextStyle: .caption2)

    dateLabel.textAlignment = .right

    barView.backgroundColor = .secondarySystemBackground

    contentView.addSubview(authorLabel)
    contentView.addSubview(contentLabel)
    contentView.addSubview(dateLabel)
    contentView.addSubview(barView)

    let views = ["author": authorLabel, "content": contentLabel, "date": dateLabel, "bar": barView]
    var constraints = [NSLayoutConstraint]()
    constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-[author]-|", options: [], metrics: nil, views: views))
    constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-[content]-|", options: [], metrics: nil, views: views))
    constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-[date]-|", options: [], metrics: nil, views: views))
    constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-[bar]-|", options: [], metrics: nil, views: views))
    constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-[author]-[content]-[date]-16-[bar(==2)]|", options: [], metrics: nil, views: views))
    NSLayoutConstraint.activate(constraints)
  }

  private func updateBar() {
    barView.isHidden = !showsBar
  }

}
