// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public protocol HTTPClient {
    func send<T: Decodable> (_ request: HTTPRequest, decodeTo type: T.Type) async throws -> T
}

public struct HTTPRequest {
    let scheme: String = "https"
    let host: String
    let path: String
    let queryItems: [URLQueryItem]
    let headers: [String: String]
    let method: HttpMethod
    let timeout: TimeInterval = 30
    let body: Data?
    
    public init(host: String,
                path: String,
                queryItems: [URLQueryItem] = [],
                headers: [String : String] = [:],
                method: HttpMethod = .get,
                body: Data? = nil
    ) {
        self.host = host
        self.path = path
        self.queryItems = queryItems
        self.headers = headers
        self.method = method
        self.body = body
    }
}

public enum HttpMethod {
    case get
    case post
    case put
    case delete
    
    var rawValue: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .delete: return "DELETE"
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case httpStatus(Int)
    case decoding(Error)
}

public class URLSessionSharedHTTPClient: HTTPClient {
    
    private let decoder: JSONDecoder
    
    public init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    public func send<T: Decodable>(
        _ request: HTTPRequest,
        decodeTo type: T.Type
    ) async throws -> T {

        var components = URLComponents()
        components.scheme = request.scheme
        components.host = request.host
        components.path = request.path
        components.queryItems = request.queryItems
        

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = request.timeout
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
   
        request.headers.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await URLSession.shared.data(for: urlRequest)
        } catch {
            throw error
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpStatus(httpResponse.statusCode)
        }

        do {

            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decoding(error)
        }
    }
}




public extension HTTPClient {
    
    func send<Body: Encodable, T: Decodable> (
        _ request: HTTPRequest,
        body: Body,
        type: T.Type,
        encoder: JSONEncoder = .defaultAPIEncoder
    ) async throws -> T {
        
        var req = request
        let data = try encoder.encode(body)

        req = HTTPRequest(
            host: request.host,
            path: request.path,
            queryItems: request.queryItems,
            headers: request.headers.merging(["Content-Type": "application/json"]) { $1 },
            method: request.method,
            body: data
        )

        return try await send(req, decodeTo: type)
    }
}
//
/*
curl -X POST \
  "https://api-jictu6k26a-uc.a.run.app/users/test-user/medications?" \
  -H "x-api-key: healthengine-mobile-test-2026" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Aspirin",
    "dosage": "500mg",
    "frequency": "daily"
  }'
 
 */

