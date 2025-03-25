//
//  AppDelegate.swift
//  deep_link_ios_test
//
//  Created by User on 25.03.2025.
// revive://app?data=test_data

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return true
    }
    
    // Обработка deep link для iOS 9+
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return handleDeepLink(url: url)
    }
    
    // Функция для обработки deep link
    private func handleDeepLink(url: URL) -> Bool {
        print("Получен Deep Link: \(url.absoluteString)")
        
        // Проверяем схему URL
        guard url.scheme == "deeplink-ios-test" else { return false }
        
        // Создаем URL для Flutter-приложения с передачей параметра test_data
        if let flutterAppURL = URL(string: "revive://app?data=test_data") {
            if UIApplication.shared.canOpenURL(flutterAppURL) {
                // Открываем Flutter-приложение
                UIApplication.shared.open(flutterAppURL, options: [:]) { success in
                    print("Открытие Flutter-приложения: \(success ? "успешно" : "неуспешно")")
                }
                return true
            } else {
                print("Невозможно открыть Flutter-приложение. Возможно, оно не установлено или URL scheme не зарегистрирован.")
                return false
            }
        }
        
        return false
    }
}
