//
//  UI.swift
//  SwiftTools
//
//  Created by Jonah Witcig on 11/10/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

public extension UIScreen {
    public static var size: CGSize {
        return UIScreen.main.bounds.size
    }
}

public extension NSLayoutConstraint {
    public func hasExceeded(_ verticalLimit: CGFloat) -> Bool {
        return constant < verticalLimit
    }
}
