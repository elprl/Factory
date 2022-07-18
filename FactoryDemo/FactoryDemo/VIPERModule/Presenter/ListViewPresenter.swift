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
    
    func onBtnPress(animal: Animal) {
        print("\(animal.name) pressed")
        let _ = router.showDetails(for: animal)
        // update view
    }
}

extension ListViewPresenter: ListViewPresenterRouterInterface {
    
}
