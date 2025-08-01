//
//  AleTrailNetworking.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/23/25.
//

import Foundation

actor AleTrailNetworking {
    func sendGetRequest<T: Decodable>(to url: URL) async throws(NetworkingError) -> T {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error as DecodingError {
            throw .decodingError(error)
        } catch let error as URLError {
            throw .urlError(error)
        } catch {
            throw .other(error)
        }
    }
}
