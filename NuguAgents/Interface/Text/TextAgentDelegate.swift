//
//  TextAgentDelegate.swift
//  NuguAgents
//
//  Created by MinChul Lee on 2019/07/19.
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

/// The `TextAgentDelegate` protocol defines method that changed state or received result.
///
/// The methods of this protocol are all optional.
public protocol TextAgentDelegate: class {
    /// Tells the delegate that `TextAgent` changed state.
    /// - Parameter state: The state for text recognition.
    func textAgentDidChange(state: TextAgentState)
    
    /// Tells the delegate that `TextAgent` received result.
    /// - Parameter result: The result of text recognition.
    func textAgentDidReceive(result: Result<Void, Error>, dialogRequestId: String)
}

// MARK: - Optional

public extension TextAgentDelegate {
    func textAgentDidChange(state: TextAgentState) {}
    func textAgentDidReceive(result: Result<Void, Error>, dialogRequestId: String) {}
}
