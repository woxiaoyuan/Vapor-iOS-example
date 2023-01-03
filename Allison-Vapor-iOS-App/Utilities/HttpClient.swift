//
//  HttpClient.swift
//  Allison-Vapor-iOS-App
//
//  Created by 耶啵的小头盔 on 12/29/22.
//

import Foundation

enum HttpMethod: String {
    case POST, GET, PUT, DELETE
}

enum HttpError: Error {
    case badURL, badResponse, errorDecodingData, invalidURL
}

enum MIMEType: String {
    case JSON = "application/json"
}

enum HttpHeaders: String {
    case contentType = "Content-Type"
}

class HttpClient {
    private init() { }
    
    static let shared = HttpClient()
    
    func fetch<T: Codable>(url: URL) async throws -> [T] {
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
        
        guard let object = try? JSONDecoder().decode([T].self, from: data) else {
            throw HttpError.errorDecodingData
        }
        return object
    }
    
    func sendData<T: Codable>(to url: URL, object: T, httpMethod: String) async throws {
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        request.addValue(MIMEType.JSON.rawValue, forHTTPHeaderField: HttpHeaders.contentType.rawValue)
        request.httpBody = try? JSONEncoder().encode(object)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
    }
    
    func delete(at id: UUID, url: URL) async throws {
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.DELETE.rawValue
        
        let (_, respond) = try await URLSession.shared.data(for: request)
        
        guard (respond as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
    }
}
