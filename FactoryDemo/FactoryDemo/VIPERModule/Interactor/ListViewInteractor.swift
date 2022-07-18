//
//  ListViewInteractor.swift
//  FactoryDemo
//
//  Created by Paul Leo on 05/07/2022.
//

import Foundation
import Factory

final class ListViewInteractor: ListViewInteractorInterface {    
    @WeakLazyInjected(ListViewContainer.presenterInteractor) var presenter
    @Injected(Container.apiService) private var apiService
}

extension ListViewInteractor: ListViewInteractorPresenterInterface {

    func fetchItems() {
        let animals = apiService.fetchAnimalNames().map { Animal(name: $0) }
        presenter?.didLoad(animals: animals)
    }
}
