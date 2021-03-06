//
//  DialogStateDelegate.swift
//  NuguClientKit
//
//  Created by MinChul Lee on 24/04/2019.
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

import NuguAgents

/// An delegate that appllication can extend to register to observe `DialogStateAggregator` state changes.
public protocol DialogStateDelegate: class {
    /// Used to notify the observer of DialogState changes.
    /// - Parameter state: The new `DialogState` of the `DialogStateAggregator`
    /// - Parameter expectSpeech: indicates `DialogState` is in progress with multiturn.
    func dialogStateDidChange(_ state: DialogState, expectSpeech: ASRExpectSpeech?)
}
