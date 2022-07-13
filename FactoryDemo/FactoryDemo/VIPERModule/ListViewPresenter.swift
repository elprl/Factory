//
//  ListViewPresenter.swift
//  FactoryDemo
//
//  Created by Paul Leo on 05/07/2022.
//

import Foundation
import Factory

final class ListViewPresenter {
    @Injected(ListViewContainer.presenterRouter) private var router
    @Injected(ListViewContainer.interactorPresenter) private var interactor
    weak var viewModel: ListViewModel?
}

extension ListViewPresenter: ListViewPresenterInteractorInterface {
    func didLoad(animals: [Animal]) {
        viewModel?.animals = animals
    }
}

extension ListViewPresenter: ListViewPresenterViewInterface {
    
    func onAppear() {
        interactor.fetchItems()
    }
    
    func onDisappear() {
        
    }
    
    func onBtnPress(animal: String) {
        print("\(animal) pressed")
    }
}

extension ListViewPresenter: ListViewPresenterRouterInterface {
    
}

final class MockListViewPresenter: ListViewPresenterViewInterface {
    weak var viewModel: ListViewModel? = nil
    
    func onAppear() {
        print("Mocking onAppear")
    }
    
    func onDisappear() {
        
    }
    
    func onBtnPress(animal: String) {
        print("\(animal) pressed")
    }
}
