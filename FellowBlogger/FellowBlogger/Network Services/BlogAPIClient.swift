//
//  BlogAPIClient.swift
//  FellowBlogger
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import Foundation

final class BlogAPIClient {
  static func getPosts(completionHandler: @escaping (AppError?, [Post]?) -> Void) {
    let getPostsEndpoint = "https://5c1d7cbdbc26950013fbcab9.mockapi.io/api/v1/posts"
    NetworkHelper.shared.performDataTask(endpointURLString: getPostsEndpoint,
                                         httpMethod: "GET",
                                         httpBody: nil) { (appError, data, httpResponse) in
                                          if let appError = appError {
                                            completionHandler(appError, nil)
                                          } else if let data = data {
                                            do {
                                              var posts = try JSONDecoder().decode([Post].self, from: data)
                                              posts = posts.sorted { $0.date > $1.date }
                                              completionHandler(nil, posts)
                                            } catch {
                                              completionHandler(AppError.decodingError(error), nil)
                                            }
                                          }
    }
  }
  
  static func publishPost(data: Data, completion: @escaping (Bool) -> Void) {
    let publishPostEndpoint = "https://5c1d7cbdbc26950013fbcab9.mockapi.io/api/v1/posts"
    NetworkHelper.shared.performUploadTask(endpointURLString: publishPostEndpoint,
                                           httpMethod: "POST",
                                           httpBody: data) { (appError, data, httpResponse) in
                                            if let _ = appError {
                                              completion(false)
                                            } else if let _ = data {
                                              completion(true)
                                            }
    }
  }
}
