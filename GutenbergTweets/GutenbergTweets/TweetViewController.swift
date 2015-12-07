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
    // MARK: public interface
    
    var layoutModel: LayoutModel = LayoutModel.defaultModel() {
        didSet {
            _applyLayoutModel(layoutModel)
        }
    }
    
    var styleModel: StyleModel = StyleModel.defaultModel() {
        didSet {
            _applyStyleModel(styleModel)
        }
    }
    
    var dataModel: DataModel = DataModel.emptyModel() {
        didSet {
            _applyDataModel(dataModel)
        }
    }
    
    // MARK: implementation internals

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var topMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingMarginConstraint: NSLayoutConstraint!

    @IBOutlet var verticalSpacingConstraints: [NSLayoutConstraint]!
    
    override func updateConstraints()
    {
        super.updateConstraints()
        _applyLayoutModel(layoutModel)
    }
    
    override init(frame: CGRect)
    {
        fatalError("programmatic init() not supported.")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        _bootstrap()
    }
    
    private func _bootstrap()
    {
        // unfortunately, sometimes our IBOutlets are still nil at this point,
        // so we throw this call onto the next runloop:
        dispatch_async(dispatch_get_main_queue()) { [weak self] () -> Void in
            if let sself = self {
                sself._applyDataModel(sself.dataModel)
                sself._applyStyleModel(sself.styleModel)
            }
        }
    }
}

extension TweetView
{
    struct LayoutModel
    {
        let topMarginConstant: CGFloat
        let bottomMarginConstant: CGFloat
        let leadingMarginConstant: CGFloat
        let trailingMarginConstant: CGFloat

        let verticalSpacingConstant: CGFloat
        
        static func defaultModel() -> LayoutModel
        {
            return LayoutModel(
                topMarginConstant: 16,
                bottomMarginConstant: 16,
                leadingMarginConstant: 8,
                trailingMarginConstant: 8,
                verticalSpacingConstant: 8)
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
}

extension TweetView
{
    struct StyleModel
    {
        let viewStyle: UIViewStyleModel
        let nameLabelStyle: UILabelStyleModel
        let dateLabelStyle: UILabelStyleModel
        let bodyLabelStyle: UILabelStyleModel
        
        static func defaultModel() -> StyleModel
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
            
            return StyleModel(
                viewStyle: viewStyle,
                nameLabelStyle: nameLabelStyle,
                dateLabelStyle: dateLabelStyle,
                bodyLabelStyle: bodyLabelStyle)
        }
    }
    
    private func _applyStyleModel(model: StyleModel)
    {
        self.applyStyleModel(model.viewStyle)
        
        for (label, model) in [
            (nameLabel, model.nameLabelStyle),
            (dateLabel, model.dateLabelStyle),
            (bodyLabel, model.bodyLabelStyle)]
        {
            label.applyStyleModel(model)
        }
    }
}

extension TweetView
{
    struct DataModel
    {
        let nameText: String
        let dateText: String
        let bodyText: String
        
        static func emptyModel() -> DataModel
        {
            return DataModel(
                nameText: "",
                dateText: "",
                bodyText: "")
        }
    }
    
    private func _applyDataModel(model: DataModel)
    {
        nameLabel.text = model.nameText
        dateLabel.text = model.dateText
        bodyLabel.text = model.bodyText
    }
}

class TweetViewController: UIViewController
{
    @IBOutlet var tweetView: TweetView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let model = TweetView.DataModel(
            nameText: "Fred",
            dateText: "Yesterday",
            bodyText: "Charlotte had seen them from her husband's room, crossing the road, and immediately running into the other, told the girls what an honour they might expect, adding:  \"I may thank you, Eliza, for this piece of civility.\"")
        
        tweetView.dataModel = model
    }
}
