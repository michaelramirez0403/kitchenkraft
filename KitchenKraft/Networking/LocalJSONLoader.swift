//
//  LocalJSONLoader.swift
//  KitchenKraft
//
//  Created by Macky Ramirez on 1/19/26.
//
import Foundation

enum LocalJSONLoader {
    static func load<T: Decodable>(_ filename: String, as type: T.Type) throws -> T {
        guard let url = Bundle.main.url(forResource: filename,
                                        withExtension: "json") else {
            throw NSError(domain: "LocalJSONLoader",
                          code: 404,
                          userInfo: [NSLocalizedDescriptionKey: "Missing \(filename).json in bundle"])
        }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
