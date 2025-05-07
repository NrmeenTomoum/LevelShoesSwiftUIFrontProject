//
//  HeaderBuilding.swift
//  Created by Nermeen Tomoum on 12/04/2025.
//

import Foundation
protocol HeaderBuilding {
    func addHeaders(to request: inout URLRequest, from endpoint: Endpoint)
}

struct DefaultHeaderBuilder: HeaderBuilding {
    func addHeaders(to request: inout URLRequest, from endpoint: Endpoint) {
        if case .body = endpoint.task {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        if endpoint.authenticationRequired {
            request.setValue("Bearer \(Constant.authToken)", forHTTPHeaderField: "Authorization")
        }
    }
}
