//
//  ViewController.swift
//  OpenTweet
//
//  Created by Olivier Larivain on 9/30/16.
//  Copyright © 2016 OpenTable, Inc. All rights reserved.
//

import UIKit

final class TimelineViewController: UIViewController {

  // MARK: Properties

  enum Section {
    case main
  }

  var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Tweet>!

  /// - Warning: Creating a new instance of DateFormatter is an expensive operation, so we'd like to have only one instance to reference.
  /// See this [Ray Wenderlich article](https://www.raywenderlich.com/2752-25-ios-app-performance-tips-tricks#reuseobjects) for more information.
  let dateFormatter = DateFormatter()

  lazy var gradientView: GradientView = {
    let lazyGradient = GradientView(frame: .zero)
    lazyGradient.translatesAutoresizingMaskIntoConstraints = false
    lazyGradient.isUserInteractionEnabled = false

    lazyGradient.colors = [UIColor.systemBackground.withAlphaComponent(0).cgColor, UIColor.systemBackground.cgColor]
    lazyGradient.startPoint = CGPoint(x: 0, y: 0)
    lazyGradient.endPoint = CGPoint(x: 0, y: 1)

    return lazyGradient
  }()

  // MARK: View Cycle

	override func viewDidLoad() {
		super.viewDidLoad()
    configureHierarchy()
    configureDataSource()
	}

}

// MARK: - Configuration and Layout

extension TimelineViewController {

  func configureHierarchy() {
    // Format navigation bar
    navigationItem.title = "OpenTweet"

    // Set up collection view
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(collectionView)
    collectionView.backgroundColor = .systemBackground

    view.addSubview(gradientView)

    // Set up constraints, with the gradient view anchored to the bottom of the screen.
    NSLayoutConstraint.activate([
      gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      // This gradient view should only be visible on notched devices.
      gradientView.heightAnchor.constraint(equalToConstant: UIDevice.current.hasNotch ? 80 : 0),

      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }

  func configureDataSource() {
    let items = JSONManager.shared.parseJson()

    // Register and configure each cell for display
    let cellRegistration = UICollectionView.CellRegistration<TweetCell, Tweet> { [weak self] (cell, indexPath, tweet) in
      cell.authorLabel.text = tweet.author

      cell.contentLabel.text = tweet.content

      self?.dateFormatter.dateStyle = .short
      self?.dateFormatter.timeStyle = .short
      cell.dateLabel.text = self?.dateFormatter.string(from: tweet.date)

      cell.showsBar = indexPath.item != items.count - 1
    }

    dataSource = UICollectionViewDiffableDataSource<Section, Tweet>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
      return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
    })

    // Data population
    var snapshot = NSDiffableDataSourceSnapshot<Section, Tweet>()
    snapshot.appendSections([.main])
    snapshot.appendItems(items, toSection: .main)
    dataSource.apply(snapshot, animatingDifferences: false)
  }

  func createLayout() -> UICollectionViewLayout {
    let estimatedHeight = CGFloat(100)
    let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))

    let item = NSCollectionLayoutItem(layoutSize: layoutSize)

    let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitem: item, count: 1)

    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    section.interGroupSpacing = 16

    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }

}

