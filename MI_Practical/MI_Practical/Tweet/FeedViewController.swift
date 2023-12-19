//
//  FeedViewController.swift
//  MI_Practical
//
//  Created by SLS M2 on 19/12/23.
//

import UIKit


class FeedViewController: UIViewController, CommentsViewControllerDelegate {
    
    
    var tweets: [Tweet] = [
        Tweet(username: "Mayur", title: "My first tweet", description: "This is a sample tweet.", image: UIImage(named: "image"),
              comments: [Comment(
                username: "Rohit Shah",
                text: "This image is looks nice",
                replies: nil)]
             ),
        Tweet(username: "Akash", title: "My first tweet", description: "This is a sample tweet.", image: UIImage(named: "image2")),
        Tweet(username: "Raj", title: "It's My first tweet", description: "This is a sample tweet.", image: UIImage(named: "image3"), comments: [Comment(
            username: "Priya Verma",
            text: "Awesome",
            replies: nil)])
    ]
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Twitter Feed"
        view.addSubview(tableView)
        
        setupTableViewConstraints()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TweetCell.self, forCellReuseIdentifier: "TweetCell")
    }
    
    
    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func didAddComment(_ comment: Comment, forTweetAtIndexPath indexPath: IndexPath) {
        tweets[indexPath.row].comments.append(comment)
        tableView.reloadData()
    }
    
    
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as? TweetCell
        let tweet = tweets[indexPath.row]
        cell?.selectionStyle = .none
        cell?.delegate = self
        cell?.isUserInteractionEnabled = true
        cell?.configure(with: tweet)
        
        return cell ?? UITableViewCell()
    }
}

extension FeedViewController: TweetCellDelegate{
    func didTapShareButton(_ cell: TweetCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let tweet = tweets[indexPath.row]
            
            let items: [Any] = [tweet.title, tweet.description]
            let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
            activityViewController.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
            present(activityViewController, animated: true, completion: nil)
        }
    }
    
    
    
    func didTapCommentButton(_ cell: TweetCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let tweet = tweets[indexPath.row]
            
   
            let commentsViewController = CommentsViewController()
            commentsViewController.tweet = tweet
            commentsViewController.delegate = self
            commentsViewController.indexPath = indexPath
        
            navigationController?.pushViewController(commentsViewController, animated: true)
        }
    }
    
}
