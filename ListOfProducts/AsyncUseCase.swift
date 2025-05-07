//
//  AsyncUseCase.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 05/05/2025.
//
import Foundation

protocol AsyncUseCase {
    associatedtype Model
    @discardableResult
    func execute() async throws -> Model
}
