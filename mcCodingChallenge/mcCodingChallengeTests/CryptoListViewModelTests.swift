//
//  mcCodingChallengeTests.swift
//  mcCodingChallengeTests
//
//  Created by Cliff on 7/11/2024.
//

import XCTest
import UIKit
import Combine
@testable import mcCodingChallenge

final class CryptoListViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    var viewModel: CryptoListViewModel!
    var mockService: MockCryptoService!
    var tableView: UITableView!

    override func setUpWithError() throws {
        mockService = MockCryptoService()
        viewModel = CryptoListViewModel(cryptoService: mockService)
        tableView = UITableView()
        tableView.dataSource = viewModel
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
        tableView = nil
    }
    
    /// Test that the title is correct
    func testTitle() {
        XCTAssertEqual(viewModel.title, "Crypto")
    }

    /// Tests that the view state updates as it should
    func testViewState() {
        let loadingExpectation = self.expectation(description: "Triggers loading")
        let contentExpectation = self.expectation(description: "Triggers display update")
        
        viewModel.viewState.sink { state in
            switch state {
            case .loading:
                loadingExpectation.fulfill()
            case .content:
                contentExpectation.fulfill()
            case .detail(_):
                XCTFail("Unexpected navigation")
            case .error:
                XCTFail("Unexpected Failure")
            }
        }.store(in: &cancellables)
        
        viewModel.fetchData()
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    /// Test that it successfully fetches and sorts crypto
    func testFetch_success() {
        // Initial check
        XCTAssertEqual(viewModel.cryptoList.count, 0)
        
        let loadingExpectation = self.expectation(description: "Triggers loading")
        let contentExpectation = self.expectation(description: "Triggers display update")
        
        viewModel.viewState.sink { state in
            switch state {
            case .loading:
                loadingExpectation.fulfill()
            case .content:
                contentExpectation.fulfill()
            case .detail(_):
                XCTFail("Unexpected navigation")
            case .error:
                XCTFail("Unexpected Failure")
            }
        }.store(in: &cancellables)
        
        viewModel.fetchData()
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
        // Check the crypto is sorted
        XCTAssertEqual(viewModel.cryptoList.count, 2)
        XCTAssertEqual(viewModel.cryptoList[0].name, "MasterCoin")
        XCTAssertEqual(viewModel.cryptoList[1].name, "CliffCoin")
    }
    
    /// Tests that it triggers error view state
    func testFetch_Failure() {
        mockService.shouldError = true
        
        // Initial check
        XCTAssertEqual(viewModel.cryptoList.count, 0)
        
        let loadingExpectation = self.expectation(description: "Triggers loading")
        let failureExpectation = self.expectation(description: "Triggers error")
        
        viewModel.viewState.sink { state in
            switch state {
            case .loading:
                loadingExpectation.fulfill()
            case .content:
                XCTFail("Unexpected success")
            case .detail(_):
                XCTFail("Unexpected navigation")
            case .error:
                failureExpectation.fulfill()
            }
        }.store(in: &cancellables)
        
        viewModel.fetchData()
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
        // Check the crypto is sorted
        XCTAssertEqual(viewModel.cryptoList.count, 0)
    }
    
    /// Test the data source returns corrext number of rows
    func testNumberOfRowsInSection() {
        let loadingExpectation = self.expectation(description: "Triggers loading")
        let contentExpectation = self.expectation(description: "Triggers display update")
        
        viewModel.viewState.sink { state in
            switch state {
            case .loading:
                loadingExpectation.fulfill()
            case .content:
                contentExpectation.fulfill()
            case .detail(_):
                XCTFail("Unexpected navigation")
            case .error:
                XCTFail("Unexpected Failure")
            }
        }.store(in: &cancellables)
        
        viewModel.fetchData()
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
        // Act
        let numberOfRows = viewModel.tableView(tableView, numberOfRowsInSection: 0)
        
        // Assert
        XCTAssertEqual(numberOfRows, 2)
    }
}
