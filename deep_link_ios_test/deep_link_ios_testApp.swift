//
//  deep_link_ios_testApp.swift
//  deep_link_ios_test
//
//  Created by User on 25.03.2025.
//

import SwiftUI

@main
struct deep_link_ios_testApp: App {
    // Используем UIApplicationDelegateAdaptor для AppDelegate без атрибута @main
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    // Дополнительная обработка URL в SwiftUI, если нужно
                    print("SwiftUI получил URL: \(url)")
                }
        }
    }
}
