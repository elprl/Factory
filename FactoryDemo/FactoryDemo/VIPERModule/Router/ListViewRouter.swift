//
//  ListViewRouter.swift
//  FactoryDemo
//
//  Created by Paul Leo on 05/07/2022.
//

import Foundation
import SwiftUI
import Factory

final class ListViewRouter: ListViewRouterInterface {
    @WeakLazyInjected(ListViewContainer.presenterRouter) var presenter
}

extension ListViewRouter: ListViewRouterPresenterInterface {
    
    func showDetails(for animal: Animal) -> any View {
        return EmptyView()
    }
}
