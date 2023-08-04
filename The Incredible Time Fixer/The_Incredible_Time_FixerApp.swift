//
//  The_Incredible_Time_FixerApp.swift
//  The Incredible Time Fixer
//
//  Created by Panagiotis Peikidis on 8/3/23.
//

import SwiftUI

@main
struct The_Incredible_Time_FixerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(
                    minWidth: 700, maxWidth: 700,
                    minHeight: 400, maxHeight: 400)
        }
        .windowResizability(.contentSize)
    }
}
