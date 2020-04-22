//
//  KeywordDetector.swift
//  NuguAgents
//
//  Created by childc on 2019/11/11.
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

import NuguCore
import KeenSense

class KeywordDetector {
    private var boundStreams: AudioBoundStreams?
    private let engine = TycheKeywordDetectorEngine()
    
    var audioStream: AudioStreamable!
    weak var delegate: KeywordDetectorDelegate?
    
    var state: KeywordDetectorState = .inactive {
        didSet {
            delegate?.keywordDetectorStateDidChange(state)
        }
    }
    
    // Must set `keywordSource` for using `KeywordDetector`
    var keywordResource: ASRKeywordResource? {
        didSet {
            engine.netFile = keywordResource?.netFileUrl
            engine.searchFile = keywordResource?.searchFileUrl
        }
    }
    
    private var keyword: String {
        keywordResource?.keyword ?? ""
    }
    
    init() {
        engine.delegate = self
    }
    
    func start() {
        boundStreams?.stop()
        boundStreams = AudioBoundStreams(audioStreamReader: audioStream.makeAudioStreamReader())
        engine.start(inputStream: boundStreams!.input)
    }
    
    func stop() {
        boundStreams?.stop()
        engine.stop()
    }
}

// MARK: - TycheKeywordDetectorEngineDelegate

extension KeywordDetector: TycheKeywordDetectorEngineDelegate {
    public func tycheKeywordDetectorEngineDidDetect(data: Data, start: Int, end: Int, detection: Int) {
        delegate?.keywordDetectorDidDetect(result: KeywordDetectorResult(keyword: keyword, data: data, start: start, end: end, detection: detection))
    }
    
    public func tycheKeywordDetectorEngineDidError(_ error: Error) {
        delegate?.keywordDetectorDidError(error)
    }
    
    public func tycheKeywordDetectorEngineDidChange(state: TycheKeywordDetectorEngine.State) {
        switch state {
        case .active:
            self.state = .active
            delegate?.keywordDetectorStateDidChange(.active)
        case .inactive:
            self.state = .inactive
            delegate?.keywordDetectorStateDidChange(.inactive)
        }
    }
}

// MARK: - ContextInfoDelegate

extension KeywordDetector: ContextInfoDelegate {
    public func contextInfoRequestContext(completion: (ContextInfo?) -> Void) {
        completion(ContextInfo(contextType: .client, name: "wakeupWord", payload: keyword))
    }
}
