//
//  ContentView.swift
//  deep_link_ios_test
//
//  Created by User on 25.03.2025.
//
// ContentView.swift
// ContentView.swift
// ContentView.swift
// ContentView.swift
// ContentView.swift
import SwiftUI

struct ContentView: View {
    // Добавляем состояние для выбора экрана
    @State private var selectedScreen: String = "activities"
    @State private var customData: String = "test_data"
    @State private var isFlutterAppInstalled: Bool = false
    
    // Доступные экраны для выбора
    let availableScreens = ["calendar", "profile"]
    
    // URL для App Store - используем правильный ID
    private let appID = "6657987267"
    
    // Схема для проверки установки приложения
    private let flutterAppScheme = "revive://"
    
    var body: some View {
        VStack(spacing: 25) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                
            Text("Deep Link Tester")
                .font(.title)
                .fontWeight(.bold)
            
            // Поле для ввода данных
            TextField("Данные для передачи", text: $customData)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            // Выбор целевого экрана
            VStack(alignment: .leading) {
                Text("Выберите целевой экран:")
                    .font(.headline)
                
                Picker("Целевой экран", selection: $selectedScreen) {
                    ForEach(availableScreens, id: \.self) { screen in
                        Text(screen.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
            }
            .padding(.horizontal)
            
            // Кнопка в зависимости от установленного приложения
            Button(action: {
                if isFlutterAppInstalled {
                    openFlutterApp(screen: selectedScreen, data: customData)
                } else {
                    openAppStore()
                }
            }) {
                Text(isFlutterAppInstalled ? "Открыть Flutter Приложение" : "Установить Flutter Приложение")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isFlutterAppInstalled ? Color.blue : Color.green)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .onAppear {
            checkIfFlutterAppInstalled()
        }
    }
    
    // Метод для проверки, установлено ли Flutter приложение
    private func checkIfFlutterAppInstalled() {
        if let flutterAppURL = URL(string: flutterAppScheme) {
            isFlutterAppInstalled = UIApplication.shared.canOpenURL(flutterAppURL)
            
            // Отладочная информация
            print("Flutter приложение \(isFlutterAppInstalled ? "установлено" : "не установлено")")
        }
    }
    
    // Функция для открытия Flutter приложения с параметрами
    private func openFlutterApp(screen: String, data: String) {
        // Создаем URL для Flutter приложения с параметрами screen и data
        // Правильное кодирование параметров по одному
        var urlComponents = URLComponents(string: "revive://app")
        urlComponents?.queryItems = [
            URLQueryItem(name: "data", value: customData),
            URLQueryItem(name: "screen", value: selectedScreen)
        ]
        
        if let flutterAppURL = urlComponents?.url {
            // Проверяем, может ли URL быть открыт
            if UIApplication.shared.canOpenURL(flutterAppURL) {
                // Открываем Flutter приложение
                UIApplication.shared.open(flutterAppURL, options: [:]) { success in
                    print("Открытие Flutter приложения: \(success ? "успешно" : "неуспешно")")
                    print("Открыт URL: \(flutterAppURL)")
                }
            } else {
                print("Невозможно открыть Flutter приложение. Возможно, оно не установлено.")
                print("Неудачный URL: \(flutterAppURL)")
            }
        }
    }
    
    // Функция для открытия App Store
    private func openAppStore() {
        // Используем сначала прямую ссылку на AppStore с правильным регионом
        let appStoreURLString = "https://apps.apple.com/ru/app/id\(appID)"
        
        if let appStoreURL = URL(string: appStoreURLString) {
            UIApplication.shared.open(appStoreURL, options: [:]) { success in
                if !success {
                    print("Не удалось открыть App Store через https, пробуем через iTunes URL")
                    
                    // Если не удалось, пробуем через iTunes URL
                    let iTunesURLString = "itms-apps://itunes.apple.com/app/id\(appID)"
                    if let iTunesURL = URL(string: iTunesURLString) {
                        UIApplication.shared.open(iTunesURL, options: [:]) { success in
                            print("Открытие App Store через itms-apps: \(success ? "успешно" : "неуспешно")")
                        }
                    }
                } else {
                    print("Открытие App Store: успешно")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
