//
//  ApiService.swift
//  FactoryDemo
//
//  Created by Paul Leo on 06/07/2022.
//

import Foundation


public protocol APIServiceProtocol {
    func fetchAnimalNames() -> [String]
}

public class APIService: APIServiceProtocol {
    public func fetchAnimalNames() -> [String] {
        return ["Badger", "Fox"]
    }
}

public class MockApiService: APIServiceProtocol {
    public func fetchAnimalNames() -> [String] {
        return ["Skunk", "Deer"]
    }
}
