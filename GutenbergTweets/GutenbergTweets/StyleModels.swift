//
//  StyleModels.swift
//  GutenbergTweets
//
//  Created by Pepas Personal on 12/6/15.
//  Copyright © 2015 Pepas Labs. All rights reserved.
//

import Foundation
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

