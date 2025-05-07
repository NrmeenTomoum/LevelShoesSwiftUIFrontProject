//
//  RequestBuilder.swift
//  Created by Nermeen Tomoum on 12/04/2025.
//


import Foundation
import Foundation
protocol RequestBuilding {
    func build(from endpoint: Endpoint) throws -> URLRequest
}

struct RequestBuilder: RequestBuilding {
    private let urlBuilder: URLBuilding
    private let bodyBuilder: BodyBuilding
    private let headerBuilder: HeaderBuilding

    init(
        urlBuilder: URLBuilding = DefaultURLBuilder(),
        bodyBuilder: BodyBuilding = DefaultBodyBuilder(),
        headerBuilder: HeaderBuilding = DefaultHeaderBuilder()
    ) {
        self.urlBuilder = urlBuilder
        self.bodyBuilder = bodyBuilder
        self.headerBuilder = headerBuilder
    }

    func build(from endpoint: Endpoint) throws -> URLRequest {
        let url = try urlBuilder.buildURL(from: endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        if let body = try bodyBuilder.buildBody(from: endpoint.task) {
            request.httpBody = body
        }

        headerBuilder.addHeaders(to: &request, from: endpoint)

        return request
    }
}
