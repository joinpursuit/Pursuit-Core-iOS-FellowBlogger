//
//  AddPostViewController.swift
//  FellowBlogger
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit

class AddPostViewController: UIViewController {
  
  @IBOutlet weak var titleTextView: UITextView!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var publishButton: UIBarButtonItem!
  
  private let titlePlaceholder = "Title"
  private let descriptionPlaceholder = "Blog description....."
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTextViews()
  }
  
  private func setupTextViews() {
    titleTextView.delegate = self
    descriptionTextView.delegate = self
    titleTextView.text = titlePlaceholder
    titleTextView.textColor = .lightGray
    descriptionTextView.text = descriptionPlaceholder
    descriptionTextView.textColor = .lightGray
  }
  
  // TODO: implement cancel button if user wants to dismiss publishing
  @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    
  }
  
  // TODO: show alert controller to update user of publish post state
  private func showAlert() {
    
  }
  
  // TODO: publish post button
  @IBAction func publishPost(_ sender: UIBarButtonItem) {
    // TODO: get title and description for Post from text views
    
    // TODO: create a timestamp for Post
    
    // TODO: initialize a Post object, leave postId blank, other requirements: author, title, description and createdAt properties
    
    // TODO: use JSONEncoder() to create Data object to upload to API
  }
}

// since UITextView does not have a placeholder property we have to emulate it ourselves using the
// delegate methods below
extension AddPostViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView == titleTextView {
      if textView.textColor == .lightGray {
        textView.text = nil
        textView.textColor = .black
      }
    } else if textView == descriptionTextView {
      if textView.textColor == .lightGray {
        textView.text = nil
        textView.textColor = .black
      }
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView == titleTextView {
      if textView.text.isEmpty {
        textView.text = titlePlaceholder
        textView.textColor = .lightGray
      }
    } else if textView == descriptionTextView {
      if textView.text.isEmpty {
        textView.text = descriptionPlaceholder
        textView.textColor = .lightGray
      }
    }
  }
}
