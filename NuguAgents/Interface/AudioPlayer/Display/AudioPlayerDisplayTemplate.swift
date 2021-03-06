//
//  AudioPlayerDisplayTemplate.swift
//  NuguAgents
//
//  Created by MinChul Lee on 2019/07/03.
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

public struct AudioPlayerDisplayTemplate {
    public let type: String
    public let payload: AudioPlayerDisplayTemplate.AudioPlayer
    public let templateId: String
    public let dialogRequestId: String
    public let playStackServiceId: String?
    
    public init(type: String, payload: AudioPlayerDisplayTemplate.AudioPlayer, templateId: String, dialogRequestId: String, playStackServiceId: String?) {
        self.type = type
        self.payload = payload
        self.templateId = templateId
        self.dialogRequestId = dialogRequestId
        self.playStackServiceId = playStackServiceId
    }
}

public extension AudioPlayerDisplayTemplate {
    /// An enum class used to specify the reason to clear the template.
    enum ClearReason {
        /// Clear request due to timeout.
        ///
        /// Application can decide whether or not to clear the template.
        case timer
        /// Clear request due to directive.
        ///
        /// Application must clear the template.
        case directive
    }
}
