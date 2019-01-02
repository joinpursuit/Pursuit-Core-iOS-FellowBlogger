//
//  ViewController.swift
//  FellowBlogger
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit

class PostsFeedViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  private var refreshControl: UIRefreshControl!
  
  private var posts = [Post]() {
    didSet {
      DispatchQueue.main.async {
        self.title = "FellowBlogger (\(self.posts.count))"
        self.tableView.reloadData()
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    setupRefreshControl()
  }
  
  private func setupRefreshControl() {
    refreshControl = UIRefreshControl()
    tableView.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(fetchPosts), for: .valueChanged)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    // we need to fetch new posts to reflect our newly published post
    // this will be handled through the delegation pattern coming up in Unit 4
    fetchPosts()
  }
  
  private func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
  
  @objc private func fetchPosts() {
    refreshControl.beginRefreshing()
    BlogAPIClient.getPosts { (appError, posts) in
      if let appError = appError {
        DispatchQueue.main.async {
          self.showAlert(title: "Error Message", message: appError.errorMessage())
        }
      } else if let posts = posts {
        self.posts = posts
      }
      DispatchQueue.main.async {
        self.refreshControl.endRefreshing()
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let indexPath = tableView.indexPathForSelectedRow,
      let postDetailViewController = segue.destination as? PostDetailViewController else {
        return
    }
    let post = posts[indexPath.row]
    postDetailViewController.post = post
  }
}

extension PostsFeedViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
    let post = posts[indexPath.row]
    cell.textLabel?.text = post.title
    cell.detailTextLabel?.text = "\(post.author) (posted: \(post.formattedDate))"
    return cell
  }
}
