//
//  TweetViewController.swift
//  GutenbergTweets
//
//  Created by Pepas Personal on 12/6/15.
//  Copyright © 2015 Pepas Labs. All rights reserved.
//

import UIKit

class TweetView: UIView
{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
}

class TweetViewController: UIViewController
{
    @IBOutlet var tweetView: TweetView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetView.nameLabel.text = "Fred"
        tweetView.dateLabel.text = "Yesterday"
        tweetView.bodyLabel.text = "Charlotte had seen them from her husband's room, crossing the road, and immediately running into the other, told the girls what an honour they might expect, adding:  \"I may thank you, Eliza, for this piece of civility."
    }
}
