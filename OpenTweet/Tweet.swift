//
//  Tweet.swift
//  OpenTweet
//
//  Created by Andrew Lvovsky on 12/3/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import Foundation

///  A model struct that contains required and optional properties of a tweet.
struct Tweet: Decodable {
  var id: String
  var author: String
  var content: String
  var date: Date

  /// The id of the tweet that is being replied to.
  var replyToTweet: String?
  var avatar: URL?
  var images: [URL]?
}

extension Tweet: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
