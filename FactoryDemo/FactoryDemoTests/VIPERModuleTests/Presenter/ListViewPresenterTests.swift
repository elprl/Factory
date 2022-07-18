//
//  ListViewPresenterTests.swift
//  FactoryDemoTests
//
//  Created by Paul Leo on 18/07/2022.
//

import XCTest
@testable import Factory
import SwiftUI
@testable import FactoryDemo

class MockRouter: ListViewRouterPresenterInterface {
    var animalName: String = ""
    
    func showDetails(for animal: FactoryDemo.Animal) -> any View {
        animalName = animal.name
        return EmptyView()
    }
}

class MockInteractor: ListViewInteractorPresenterInterface {
    var didFetchItems = false
    
    func fetchItems() {
        didFetchItems = true
    }
}

class MockView: ListViewInteractorPresenterInterface {
    var didFetchItems = false
    
    func fetchItems() {
        didFetchItems = true
    }
}

final class ListViewPresenterTests: XCTestCase {
    
    func testViewPresenterEvents() throws {        
        let vm = ListViewModel()
        ListViewContainer.viewModel.register { vm }

        let presenter = ListViewPresenter()
        presenter.didLoad(animals: [Animal(name: "Spider"), Animal(name: "Mouse")])
        XCTAssertTrue(vm.animals.count == 2)
    }

    func testPresenterInteractorEvents() throws {
        let mockInteractor = MockInteractor()
        ListViewContainer.interactorPresenter.register { mockInteractor }

        let presenter = ListViewPresenter()
        presenter.onAppear()
        XCTAssertTrue(mockInteractor.didFetchItems == true)
    }
    
    func testPresenterRouterEvents() throws {
        let mockRouter = MockRouter()
        ListViewContainer.routerPresenter.register { mockRouter }

        let presenter = ListViewPresenter()
        presenter.onBtnPress(animal: Animal(name: "Mouse"))
        XCTAssertTrue(mockRouter.animalName == "Mouse")
    }
}
