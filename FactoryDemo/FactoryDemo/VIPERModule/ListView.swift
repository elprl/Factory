//
//  ListView.swift
//  FactoryDemo
//
//  Created by Paul Leo on 05/07/2022.
//

import Foundation
import SwiftUI
import Factory

struct ListView: View {
    @Injected(ListViewContainer.presenterView) private var presenter
    @Injected(ListViewContainer.viewModel) private var viewModel

    var body: some View {
        List(viewModel.animals) { animal in
            Button {
                self.presenter.onBtnPress(animal: animal.name)
            } label: {
                Text(animal.name)
            }
        }
        .onAppear {
            presenter.onAppear()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let _ = SharedContainer.setupListViewPreviewMocks()
        ListView()
    }
}
