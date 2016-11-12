//
//  UIKit.swift
//  SwiftTools
//
//  Created by Jonah Witcig on 11/10/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

public extension UITextView {
    public func recalculateVerticalAlignment() {
        let calculatedY = (bounds.size.height - contentSize.height * zoomScale) / 2.0
        contentInset = UIEdgeInsets(top: calculatedY < 0 ? 0 : calculatedY, left: 0, bottom: 0, right: 0)
    }
}
