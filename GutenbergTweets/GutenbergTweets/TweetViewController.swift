//
//  TweetViewController.swift
//  GutenbergTweets
//
//  Created by Pepas Personal on 12/6/15.
//  Copyright © 2015 Pepas Labs. All rights reserved.
//

import UIKit

protocol UIViewStyleModelProtocol
{
    var backgroundColor: UIColor { get }
}

protocol UILabelStyleModelProtocol: UIViewStyleModelProtocol
{
    var font: UIFont { get }
    var textColor: UIColor { get }
}

struct UIViewStyleModel: UIViewStyleModelProtocol
{
    let backgroundColor: UIColor
}

struct UILabelStyleModel: UILabelStyleModelProtocol
{
    let backgroundColor: UIColor
    let font: UIFont
    let textColor: UIColor
}

extension UIView
{
    func applyStyleModel(model: UIViewStyleModelProtocol)
    {
        backgroundColor = model.backgroundColor
    }
}

extension UILabel
{
    func applyStyleModel(model: UILabelStyleModelProtocol)
    {
        font = model.font
        backgroundColor = model.backgroundColor
        textColor = model.textColor
    }
}

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

    struct LayoutModel
    {
        let topMarginConstant: CGFloat = 16
        let bottomMarginConstant: CGFloat = 8
        let leadingMarginConstant: CGFloat = 8
        let trailingMarginConstant: CGFloat = 8

        let verticalSpacingConstant: CGFloat = 8
    }
    
    var layoutModel: LayoutModel = LayoutModel() {
        didSet {
            _applyLayoutModel(layoutModel)
        }
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

    override func updateConstraints() {
        super.updateConstraints()
        _applyLayoutModel(layoutModel)
    }
    
    struct StyleModel
    {
        let viewStyle: UIViewStyleModel = UIViewStyleModel(backgroundColor: UIColor.whiteColor())
        
        let nameLabelStyle: UILabelStyleModel = UILabelStyleModel(
            backgroundColor: UIColor.whiteColor(),
            font: UIFont.systemFontOfSize(18),
            textColor: UIColor.darkGrayColor())
        
        let dateLabelStyle: UILabelStyleModel = UILabelStyleModel(
            backgroundColor: UIColor.whiteColor(),
            font: UIFont.systemFontOfSize(14),
            textColor: UIColor.darkGrayColor())
        
        let bodyLabelStyle: UILabelStyleModel = UILabelStyleModel(
            backgroundColor: UIColor.whiteColor(),
            font: UIFont.systemFontOfSize(14),
            textColor: UIColor.darkGrayColor())
    }
    
    var styleModel: StyleModel = StyleModel() {
        didSet {
            _applyStyleModel(styleModel)
        }
    }
    
    private func _applyStyleModel(model: StyleModel)
    {
        applyStyleModel(model.viewStyle)
        
        for (label, model) in [
            (nameLabel, model.nameLabelStyle),
            (dateLabel, model.dateLabelStyle),
            (bodyLabel, model.bodyLabelStyle),
            ]
        {
            label.applyStyleModel(model)
        }
    }
    
    override init(frame: CGRect) {
        fatalError("programmatic init() not supported.")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // unfortunately, sometimes our IBOutlets are still nil at this point,
        // so we throw this call onto the next runloop:
        dispatch_async(dispatch_get_main_queue()) { [weak self] () -> Void in
            if let zelf = self {
                zelf._applyStyleModel(zelf.styleModel)
            }
        }
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
