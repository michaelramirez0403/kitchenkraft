//
//  AppCoordinator.swift
//  KitchenKraft
//
//  Created by Macky Ramirez on 1/19/26.
//
import SwiftUI
internal import Combine

@MainActor
final class AppCoordinator: ObservableObject {
    @Published var path: [Route] = []

    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        _ = path.popLast()
    }

    func popToRoot() {
        path.removeAll()
    }
}
