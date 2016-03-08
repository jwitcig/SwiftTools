//
//  STEnums.swift
//  SwiftTools
//
//  Created by Developer on 3/8/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import Cocoa
#endif

public enum PredicateComparator: String {
    case Equals = "=="
    case Contains = "CONTAINS"
    case In = "IN"
}

public enum Sort {
    case Chronological
    case ReverseChronological
}

