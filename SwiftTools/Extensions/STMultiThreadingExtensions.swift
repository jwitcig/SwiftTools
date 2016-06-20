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

let userInteractiveThread = DispatchQueue.global(attributes: DispatchQueue.GlobalAttributes(rawValue: UInt64(Int(DispatchQueueAttributes.qosUserInteractive.rawValue))))
let userInitiatedThread = DispatchQueue.global(attributes: DispatchQueue.GlobalAttributes(rawValue: UInt64(Int(DispatchQueueAttributes.qosUserInitiated.rawValue))))
let backgroundThread = DispatchQueue.global(attributes: DispatchQueue.GlobalAttributes(rawValue: UInt64(Int(DispatchQueueAttributes.noQoS.rawValue))))

public func runOnMainThread(_ block: (()->())) {
    DispatchQueue.main.async(execute: block)
}

public func runOnUserInteractiveThread(_ block: (()->())) {
    userInteractiveThread.async(execute: block)
}

public func runOnUserInitiatedThread(_ block: (()->())) {
    userInitiatedThread.async(execute: block)
}

public func runOnBackgroundThread(_ block: (()->())) {
    backgroundThread.async(execute: block)
}
