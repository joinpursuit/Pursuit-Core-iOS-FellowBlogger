//
//  Post.swift
//  FellowBlogger
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import Foundation

struct Post: Codable {
  let postId: String
  let author: String
  let title: String
  let description: String
  let createdAt: String
  
  public var formattedDate: String {
    let isoDateFormatter = ISO8601DateFormatter()
    var createdDate = ""
    if let date = isoDateFormatter.date(from: createdAt) {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MMMM, dd, yyyy h:mm a"
      createdDate = dateFormatter.string(from: date)
    }
    return createdDate
  }
}
