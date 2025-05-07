//
//  BodyBuilding.swift
//  Created by Nermeen Tomoum on 12/04/2025.
//
import Foundation


protocol BodyBuilding {
    func buildBody(from task: EncodingTask) throws -> Data?
}

struct DefaultBodyBuilder: BodyBuilding {
    func buildBody(from task: EncodingTask) throws -> Data? {
        switch task {
        case .body(let parameters, let encoder):
            return try parameters.encode(with: encoder)
        default:
            return nil
        }
    }
}
