//
//  CommentViewController.swift
//  MI_Practical
//
//  Created by SLS M2 on 19/12/23.
//
import UIKit

protocol CommentsViewControllerDelegate: AnyObject {
    func didAddComment(_ comment: Comment, forTweetAtIndexPath indexPath: IndexPath)
}

class CommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    weak var delegate: CommentsViewControllerDelegate?
    var tweet: Tweet?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    deinit {
        // Unregister keyboard notifications when the view controller is deallocated
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupUI() {
        // Configure the UI as needed
        title = "Comments"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CommentCell")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        // Add a button to add new comments using an alert
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddCommentAlert))
    }
    
    @objc func showAddCommentAlert() {
        let alertController = UIAlertController(title: "Add Comment", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter your comment"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            if let commentText = alertController.textFields?.first?.text, !commentText.isEmpty {
                let newComment = Comment(username: self.tweet?.username ?? "User", text: commentText)
                self.tweet?.comments.append(newComment)
                self.tableView.reloadData()
                
                // Notify the delegate about the new comment
                if let indexPath = self.indexPath {
                    self.delegate?.didAddComment(newComment, forTweetAtIndexPath: indexPath)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweet?.comments.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)
        if let comment = tweet?.comments[indexPath.row] {
            cell.textLabel?.text = "\(comment.username): \(comment.text)"
        }
        return cell
    }
}
