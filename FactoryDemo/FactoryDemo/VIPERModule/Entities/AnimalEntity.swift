//
//  AnimalEntity.swift
//  FactoryDemo
//
//  Created by Paul Leo on 05/07/2022.
//

import Foundation

struct Animal: Identifiable {
    let name: String
    
    var id: String { name }
}
