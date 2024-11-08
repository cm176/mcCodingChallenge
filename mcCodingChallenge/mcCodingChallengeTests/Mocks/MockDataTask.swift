//
//  MockDataTask.swift
//  mcCodingChallengeTests
//
//  Created by Cliff on 8/11/2024.
//

import Foundation

class MockDataTask: URLSessionDataTask {
    override func resume() {
        // Do nothing, we’re not actually making network requests
    }
}
