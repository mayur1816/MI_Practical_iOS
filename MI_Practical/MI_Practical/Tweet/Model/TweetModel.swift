//
//  TweetModel.swift
//  MI_Practical
//
//  Created by SLS M2 on 19/12/23.
//

import Foundation
import UIKit

struct Tweet {
    let username: String
    let title: String
    let description: String
    let image: UIImage?
    var comments: [Comment] = []
}

struct Comment {
    var username: String
    var text: String
    var replies: [Comment]?
}
