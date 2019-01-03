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
  
  @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  private func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default) { (alertAction) in
      self.dismiss(animated: true, completion: nil)
    }
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
  
  @IBAction func publishPost(_ sender: UIBarButtonItem) {
    guard let titleText = titleTextView.text,
      let descriptionText = descriptionTextView.text else {
        return
    }
    publishButton.isEnabled = false
    let date = Date() // current date
    let isoDateFormatter = ISO8601DateFormatter()
    isoDateFormatter.timeZone = TimeZone.current
    isoDateFormatter.formatOptions = [.withFullDate,
                                      .withInternetDateTime,
                                      .withDashSeparatorInDate,
                                      .withColonSeparatorInTime]
    let timeStamp = isoDateFormatter.string(from: date)
    
    // initialize Post object to be sent to API
    #error ("author name required")
    let post = Post.init(postId: "", author: "", title: titleText, description: descriptionText, createdAt: timeStamp)
    
    do {
      let data = try JSONEncoder().encode(post)
      BlogAPIClient.publishPost(data: data) { (success) in
        if success {
          DispatchQueue.main.async {
            self.showAlert(title: "Published successfully", message: "")
          }
        } else {
          DispatchQueue.main.async {
            self.showAlert(title: "Error Publishing", message: "")
          }
        }
        DispatchQueue.main.sync {
          self.publishButton.isEnabled = true
        }
      }
    } catch {
      showAlert(title: "Error Publishing", message: "\(error)")
      publishButton.isEnabled = true
    }
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
