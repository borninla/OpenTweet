//
//  JSONManager.swift
//  OpenTweet
//
//  Created by Andrew Lvovsky on 12/5/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import Foundation

/// A singleton manager class used for extracting JSON data.
final class JSONManager {

  static let shared = JSONManager()

  // Note: The JSON's key's name may vary from the filename,
  // so defining two separate constants just in case.
  let filename = "timeline"
  let jsonKeyName = "timeline"

  private func extractJsonData(from filename: String) -> Data? {
    do {
      if let file = Bundle.main.path(forResource: filename, ofType: "json"),
         let jsonData = try String(contentsOfFile: file).data(using: .utf8) {
        return jsonData
      }
    } catch {
      print(error)
    }

    return nil
  }

  public func parseJson() -> [Tweet] {
    guard let jsonData = extractJsonData(from: filename) else { return [] }

    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601

    let parsedJson: [String: [Tweet]] = try! decoder.decode([String: [Tweet]].self, from: jsonData)
    let tweets = parsedJson[jsonKeyName] ?? []
    return tweets
  }

}
