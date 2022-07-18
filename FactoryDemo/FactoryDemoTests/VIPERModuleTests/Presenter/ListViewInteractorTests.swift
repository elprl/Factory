//
//  ListViewInteractorTests.swift
//  FactoryDemoTests
//
//  Created by Paul Leo on 18/07/2022.
//

import XCTest
@testable import Factory
import SwiftUI
@testable import FactoryDemo

class MockPresenter: ListViewPresenterInteractorInterface {
    var animals: [FactoryDemo.Animal] = []
    
    func didLoad(animals: [FactoryDemo.Animal]) {
        self.animals = animals
    }
}

final class ListViewInteractorTests: XCTestCase {

    func testPresenterEvents() throws {
        let mockPresenter = MockPresenter()
        ListViewContainer.presenterInteractor.register { mockPresenter }
        Container.apiService.register { MockApiService() }

        let interactor = ListViewInteractor()
        interactor.fetchItems()
        XCTAssertTrue(mockPresenter.animals.isEmpty == false)
        XCTAssertTrue(mockPresenter.animals.first?.name == "Skunk")
    }

}
