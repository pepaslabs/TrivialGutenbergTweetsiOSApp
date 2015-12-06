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
    
    @IBOutlet weak var topMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingMarginConstraint: NSLayoutConstraint!

    @IBOutlet var verticalSpacingConstraints: [NSLayoutConstraint]!
    
    var layoutModel: LayoutModel = LayoutModel() {
        didSet {
            _applyLayoutModel(layoutModel)
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        _applyLayoutModel(layoutModel)
    }
    
    private func _applyLayoutModel(model: LayoutModel)
    {
        topMarginConstraint.constant = model.topMarginConstant
        bottomMarginConstraint.constant = model.bottomMarginConstant
        leadingMarginConstraint.constant = model.leadingMarginConstant
        trailingMarginConstraint.constant = model.trailingMarginConstant
        
        for constraint in verticalSpacingConstraints
        {
            constraint.constant = model.verticalSpacingConstant
        }
    }
    
    struct LayoutModel
    {
        let topMarginConstant: CGFloat = 16
        let bottomMarginConstant: CGFloat = 8
        let leadingMarginConstant: CGFloat = 8
        let trailingMarginConstant: CGFloat = 8
        
        let verticalSpacingConstant: CGFloat = 8
    }
}

class TweetViewController: UIViewController
{
    @IBOutlet var tweetView: TweetView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetView.nameLabel.text = "Fred"
        tweetView.dateLabel.text = "Yesterday"
        tweetView.bodyLabel.text = "Charlotte had seen them from her husband's room, crossing the road, and immediately running into the other, told the girls what an honour they might expect, adding:  \"I may thank you, Eliza, for this piece of civility.\""
    }
}
