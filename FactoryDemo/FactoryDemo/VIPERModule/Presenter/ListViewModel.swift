//
//  ListViewModel.swift
//  FactoryDemo
//
//  Created by Paul Leo on 05/07/2022.
//

import Foundation
import SwiftUI

final class ListViewModel: ObservableObject {
    @Published var animals: [Animal] = []
}
