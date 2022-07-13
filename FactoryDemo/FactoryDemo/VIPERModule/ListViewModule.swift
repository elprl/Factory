//
//  ListViewModule.swift
//  FactoryDemo
//
//  Created by Paul Leo on 06/07/2022.
//

import Foundation
import SwiftUI
import Factory

// MARK: - Router

protocol ListViewRouterInterface: ListViewRouterPresenterInterface {
    var presenter: ListViewPresenterRouterInterface! { get set }
}

protocol ListViewRouterPresenterInterface: AnyObject {
    func showDetails(for animal: Animal) -> any View
}

// MARK: - Presenter

protocol ListViewPresenterInterface: ListViewPresenterRouterInterface, ListViewPresenterInteractorInterface, ListViewPresenterViewInterface {
    var router: ListViewRouterPresenterInterface! { get set }
    var interactor: ListViewInteractorPresenterInterface! { get set }
}

protocol ListViewPresenterRouterInterface: AnyObject {

}

protocol ListViewPresenterInteractorInterface: AnyObject {
    func didLoad(animals: [Animal])
}

protocol ListViewPresenterViewInterface: AnyObject {
    var viewModel: ListViewModel? { get set }
    func onAppear()
    func onBtnPress(animal: String)
}

// MARK: - Interactor

protocol ListViewInteractorInterface: ListViewInteractorPresenterInterface {
    var presenter: ListViewPresenterInteractorInterface! { get set }
}

protocol ListViewInteractorPresenterInterface: AnyObject {
    func fetchItems()
}

extension Container {
    static let apiService = Factory<APIServiceProtocol>(scope: .shared) { APIService() }
}

extension SharedContainer {
    
    static func setupListViewPreviewMocks() {
        ListViewContainer.viewModel.register {
            let vm = ListViewModel()
            vm.animals = [Animal(name: "Horse")]
            return vm
        }
        ListViewContainer.presenter.register { MockListViewPresenter() }

#if DEBUG
        Decorator.decorate = {
            print("FACTORY: \(type(of: $0)) (\(Int(bitPattern: ObjectIdentifier($0 as AnyObject))))")
        }
#endif
    }
    
    static func setupDemoContainer() {
        Container.apiService.register { APIService() }
        ListViewContainer.viewModel.register {
            let vm = ListViewModel()
            vm.animals = [Animal(name: "Spider"), Animal(name: "Mouse")]
            return vm
        }
        ListViewContainer.interactor.register { ListViewInteractor() }
        ListViewContainer.router.register { ListViewRouter() }
        ListViewContainer.presenter.register { ListViewPresenter() }

#if DEBUG
        Decorator.decorate = {
            print("FACTORY: \(type(of: $0)) (\(Int(bitPattern: ObjectIdentifier($0 as AnyObject))))")
        }
#endif
    }
}

class ListViewContainer: SharedContainer {
    static let viewModel = Factory<ListViewModel>(scope: .shared) { ListViewModel() }
    static let presenter = Factory<ListViewPresenterInterface>(scope: .shared) { ListViewPresenter() }
    static let interactor = Factory<ListViewInteractorInterface>(scope: .shared) { ListViewInteractor() }
    static let router = Factory<ListViewRouterInterface>(scope: .shared) { ListViewRouter() }
}

final class ListViewModule {
    @Injected(ListViewContainer.viewModel) private var viewModel
    @Injected(ListViewContainer.presenter) private var presenter
    @Injected(ListViewContainer.interactor) private var interactor
    @Injected(ListViewContainer.router) private var router

    func build() -> some View {
        presenter.viewModel = self.viewModel
        presenter.router = (self.router as ListViewRouterPresenterInterface)
        presenter.interactor = (self.interactor as ListViewInteractorPresenterInterface)
        let view = ListView(presenter: (self.presenter as ListViewPresenterViewInterface))
        interactor.presenter = (self.presenter as ListViewPresenterInteractorInterface)
        router.presenter = (self.presenter as ListViewPresenterRouterInterface)
        return view
    }
}
