//
//  Operators.swift
//  SwiftTools
//
//  Created by Jonah Witcig on 11/10/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

infix operator |
public func | (shouldCall: Bool, function: (()->Void)?) {
    if shouldCall {
        function?()
    }
}
