//
//  AleTrailNetworking.swift
//  AleTrail
//
//  Created by Jillian Scott on 7/23/25.
//

import Foundation

actor AleTrailNetworking {
    func sendGetRequest<T: Decodable>(to url: URL, type: T.Type = T.self) async throws(NetworkingError) -> T {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch let error as DecodingError {
            throw .decodingError(error)
        } catch let error as URLError {
            throw .urlError(error)
        } catch {
            throw .other(error)
        }
    }
}

