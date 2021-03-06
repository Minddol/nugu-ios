//
//  UpstreamEventMessage.swift
//  NuguCore
//
//  Created by MinChul Lee on 22/05/2019.
//  Copyright (c) 2019 SK Telecom Co., Ltd. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

/// <#Description#>
public struct UpstreamEventMessage {
    /// <#Description#>
    public let payload: [String: Any]
    /// <#Description#>
    public let header: UpstreamHeader
    /// <#Description#>
    public let contextPayload: ContextPayload
    
    /// <#Description#>
    /// - Parameter payload: <#payload description#>
    /// - Parameter header: <#header description#>
    /// - Parameter contexts: <#contexts description#>
    public init(payload: [String: Any], header: UpstreamHeader, contextPayload: ContextPayload) {
        self.payload = payload
        self.header = header
        self.contextPayload = contextPayload
    }
    
    public var headerString: String {
        let headerDictionary = ["namespace": header.namespace,
                                "name": header.name,
                                "dialogRequestId": header.dialogRequestId,
                                "messageId": header.messageId,
                                "version": header.version]

        guard let data = try? JSONSerialization.data(withJSONObject: headerDictionary, options: []),
            let headerString = String(data: data, encoding: .utf8) else {
                return ""
        }
        
        return headerString
    }
    
    /// <#Description#>
    public var payloadString: String {
        guard
            let data = try? JSONSerialization.data(withJSONObject: payload, options: []),
            let payloadString = String(data: data, encoding: .utf8) else {
                return ""
        }
        
        return payloadString
    }
    
    /// <#Description#>
    public var contextString: String {
        let supportedInterfaces = contextPayload.supportedInterfaces.reduce(
            into: [String: Any]()
        ) { result, context in
            result[context.name] = context.payload
        }
        let client = contextPayload.client.reduce(
            into: [String: Any]()
        ) { result, context in
            result[context.name] = context.payload
        }
        
        let contextDict: [String: Any] = [
            "supportedInterfaces": supportedInterfaces,
            "client": client
        ]
        
        guard
            let data = try? JSONSerialization.data(withJSONObject: contextDict.compactMapValues { $0 }, options: []),
            let contextString = String(data: data, encoding: .utf8) else {
                return ""
        }
        
        return contextString
    }
}
