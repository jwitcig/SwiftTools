//
//  Messages.swift
//  SwiftTools
//
//  Created by Jonah Witcig on 11/10/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

import Messages

@available(iOS 10.0, *)
public extension MSMessage {
    public static func isFromCurrentDevice(message: MSMessage, conversation: MSConversation) -> Bool {
        return message.senderParticipantIdentifier == conversation.localParticipantIdentifier
    }
}
