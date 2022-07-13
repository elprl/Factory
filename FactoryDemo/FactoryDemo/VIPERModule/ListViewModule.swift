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

protocol ListViewRouterPresenterInterface: RouterPresenterInterface {
    func showDetails(for animal: Animal) -> any View
}

// MARK: - Presenter

protocol ListViewPresenterRouterInterface: PresenterRouterInterface {

}

protocol ListViewPresenterInteractorInterface: PresenterInteractorInterface {
    func didLoad(animals: [Animal])
}

protocol ListViewPresenterViewInterface: PresenterViewInterface {
    var viewModel: ListViewModel? { get set }
    func onAppear()
    func onBtnPress(animal: String)
}

// MARK: - Interactor

protocol ListViewInteractorPresenterInterface: InteractorPresenterInterface {
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
        ListViewContainer.presenterView.register { MockListViewPresenter() }

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
        ListViewContainer.presenter.register { ListViewPresenter() }
        ListViewContainer.router.register { ListViewRouter() }

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
    
    static let presenterInteractor = Factory<ListViewPresenterInteractorInterface>(scope: .shared) { presenter() }
    static let presenterRouter = Factory<ListViewPresenterRouterInterface>(scope: .shared) { presenter() }
    static let presenterView = Factory<ListViewPresenterViewInterface>(scope: .shared) { presenter() }
    
    static let interactorPresenter = Factory<ListViewInteractorPresenterInterface>(scope: .shared) { interactor() }

    static let routerPresenter = Factory<ListViewRouterPresenterInterface>(scope: .shared) { router() }
}

final class ListViewModule {
    @Injected(ListViewContainer.viewModel) private var viewModel
    @Injected(ListViewContainer.presenter) private var presenter
    @Injected(ListViewContainer.interactor) private var interactor
    @Injected(ListViewContainer.router) private var router

    @Injected(ListViewContainer.presenterInteractor) private var presenterInteractor
    @Injected(ListViewContainer.presenterRouter) private var presenterRouter
    @Injected(ListViewContainer.presenterView) private var presenterView
    @Injected(ListViewContainer.interactorPresenter) private var interactorPresenter
    @Injected(ListViewContainer.routerPresenter) private var routerPresenter

    func build() -> some View {
        presenter.viewModel = self.viewModel
        let view = ListView()
        interactor.presenter = self.presenterInteractor
        router.presenter = self.presenterRouter
        return view
    }
}
