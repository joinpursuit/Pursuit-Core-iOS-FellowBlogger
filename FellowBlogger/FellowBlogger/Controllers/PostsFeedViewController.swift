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
  
  // TODO: declare refresh control
  
  private var posts = [Post]()

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    // we need to fetch new posts to reflect our newly published post
    // this will be handled through the delegation pattern coming up in Unit 4
  }
  
  // TODO: write function to setup refresh control
  
  private func fetchPosts() {
    // TODO: implement 
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
