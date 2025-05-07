//
//  URLSessionProtocol.swift
//  App
//
//  Created by Nermeen Tomoum on 15/04/2025.
//
import Foundation
import Combine

// MARK: - URLSession
protocol URLSessionProtocol {
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol{}
