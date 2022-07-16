//
//  ListViewPresenter.swift
//  FactoryDemo
//
//  Created by Paul Leo on 05/07/2022.
//

import Foundation
import Factory

class ListViewPresenter: ListViewPresenterInterface {    
    @Injected(ListViewContainer.routerPresenter) var router
    @Injected(ListViewContainer.interactorPresenter) var interactor
    @WeakLazyInjected(ListViewContainer.viewModel) var viewModel
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

//final class MockListViewPresenter: ListViewPresenterInterface {
//    func didLoad(animals: [Animal]) {
//
//    }
//
//    var router: ListViewRouterPresenterInterface
//    var interactor: ListViewInteractorPresenterInterface
//    weak var viewModel: ListViewModel?
//
//    func onAppear() {
//        print("Mocking onAppear")
//    }
//
//    func onDisappear() {
//
//    }
//
//    func onBtnPress(animal: String) {
//        print("\(animal) pressed")
//    }
//}
