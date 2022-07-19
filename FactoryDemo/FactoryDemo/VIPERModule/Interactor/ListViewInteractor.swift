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
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
            guard let self = self else { return }
            let animals = self.apiService.fetchAnimalNames().map { Animal(name: $0) }
            self.presenter?.didLoad(animals: animals)
        }
    }
}
