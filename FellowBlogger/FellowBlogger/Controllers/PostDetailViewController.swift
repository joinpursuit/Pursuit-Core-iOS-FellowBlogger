//
//  PostDetailViewController.swift
//  FellowBlogger
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
  
  @IBOutlet weak var blogDescription: UITextView!
  
  public var post: Post! 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = post.title
    blogDescription.isEditable = false
    blogDescription.text = post.description
  }
}
