//
//  ListViewPresenter.swift
//  FactoryDemo
//
//  Created by Paul Leo on 05/07/2022.
//

import Foundation
import Factory

class ListViewPresenter: PresenterInterface {
    var router: ListViewRouterPresenterInterface!
    var interactor: ListViewInteractorPresenterInterface!
    weak var viewModel: ListViewModel?
}

extension ListViewPresenter: ListViewPresenterInteractorInterface {
    func didLoad(animals: [Animal]) {
        viewModel?.animals = animals
    }
}

extension ListViewPresenter: ListViewPresenterViewInterface {
    
    @objc func onAppear() {
        interactor.fetchItems()
    }
    
    @objc func onDisappear() {
        
    }
    
    @objc func onBtnPress(animal: String) {
        print("\(animal) pressed")
    }
}

extension ListViewPresenter: ListViewPresenterRouterInterface {
    
}

final class MockListViewPresenter: ListViewPresenter {
//    var router: ListViewRouterPresenterInterface!
//    var interactor: ListViewInteractorPresenterInterface!
//    weak var viewModel: ListViewModel?

    override func onAppear() {
        print("Mocking onAppear")
    }
    
    override func onDisappear() {
        
    }
    
    override func onBtnPress(animal: String) {
        print("\(animal) pressed")
    }
}
