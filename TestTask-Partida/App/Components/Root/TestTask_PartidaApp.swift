//
//  TestTask_PartidaApp.swift
//  TestTask-Partida
//
//  Created by Zufar Suleimanov on 22.05.2025.
//

import SwiftUI

@main
struct TestTask_PartidaApp: App {
    @State var appCoordinator = AppCoordinatorViewModel()
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(coordinator: appCoordinator)
        }
    }
}
