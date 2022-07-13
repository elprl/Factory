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
    weak var presenter: ListViewPresenterRouterInterface!
}

extension ListViewRouter: ListViewRouterPresenterInterface {
    
    func showDetails(for animal: Animal) -> any View {
        return EmptyView()
    }
}
