//
//  STMultiThreading.swift
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

let userInteractiveThread = dispatch_get_global_queue(Int(QOS_CLASS_USER_INTERACTIVE.rawValue), 0)
let userInitiatedThread = dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)
let backgroundThread = dispatch_get_global_queue(Int(QOS_CLASS_UNSPECIFIED.rawValue), 0)

public func runOnMainThread(block: (()->())) {
    dispatch_async(dispatch_get_main_queue(), block)
}

public func runOnUserInteractiveThread(block: (()->())) {
    dispatch_async(userInteractiveThread, block)
}

public func runOnUserInitiatedThread(block: (()->())) {
    dispatch_async(userInitiatedThread, block)
}

public func runOnBackgroundThread(block: (()->())) {
    dispatch_async(backgroundThread, block)
}
