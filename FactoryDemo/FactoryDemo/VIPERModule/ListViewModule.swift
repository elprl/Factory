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
    /*weak*/ var presenter: ListViewPresenterRouterInterface? { get set }
}

protocol ListViewRouterPresenterInterface: AnyObject {
    func showDetails(for animal: Animal) -> any View
}

// MARK: - Presenter

protocol ListViewPresenterInterface: ListViewPresenterRouterInterface, ListViewPresenterInteractorInterface, ListViewPresenterViewInterface {
    var router: ListViewRouterPresenterInterface { get set }
    var interactor: ListViewInteractorPresenterInterface { get set }
    /*weak*/ var viewModel: ListViewModel? { get set }
}

protocol ListViewPresenterRouterInterface: AnyObject {

}

protocol ListViewPresenterInteractorInterface: AnyObject {
    func didLoad(animals: [Animal])
}

protocol ListViewPresenterViewInterface: AnyObject {
    func onAppear()
    func onBtnPress(animal: String)
}

// MARK: - Interactor

protocol ListViewInteractorInterface: ListViewInteractorPresenterInterface {
    /*weak*/ var presenter: ListViewPresenterInteractorInterface? { get set }
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
        ListViewContainer.presenterView.register { ListViewPresenter() }

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
    static let presenter = Factory<ListViewPresenter>(scope: .shared) { ListViewPresenter() }
    static let interactor = Factory<ListViewInteractor>(scope: .shared) { ListViewInteractor() }
    static let router = Factory<ListViewRouter>(scope: .shared) { ListViewRouter() }
    
    static let routerPresenter  = Factory<ListViewRouterPresenterInterface>(scope: .shared) { router() }
    static let interactorPresenter = Factory<ListViewInteractorPresenterInterface>(scope: .shared) { interactor() }
    static let presenterView = Factory<ListViewPresenterViewInterface>(scope: .shared) { presenter() }
    static let presenterInteractor  = Factory<ListViewPresenterInteractorInterface>(scope: .shared) { presenter() }
    static let presenterRouter = Factory<ListViewPresenterRouterInterface>(scope: .shared) { presenter() }
}

final class ListViewModule {
    @Injected(ListViewContainer.viewModel) private var viewModel
    @Injected(ListViewContainer.presenter) private var presenter
    @Injected(ListViewContainer.interactor) private var interactor
    @Injected(ListViewContainer.router) private var router

    func build() -> some View {
        let view = ListView()
        return view
    }
}
