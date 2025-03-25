//
//  ContentView.swift
//  deep_link_ios_test
//
//  Created by User on 25.03.2025.
//
// ContentView.swift
import SwiftUI

struct ContentView: View {
    // Добавляем состояние для выбора экрана
    @State private var selectedScreen: String = "activities"
    @State private var customData: String = "test_data"
    
    // Доступные экраны для выбора
    let availableScreens = ["activities", "profile", "workout"]
    
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
            
            // Кнопка для открытия Flutter приложения
            Button(action: {
                openFlutterApp(screen: selectedScreen, data: customData)
            }) {
                Text("Открыть Flutter Приложение")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
    
    // Функция для открытия Flutter приложения с параметрами
    private func openFlutterApp(screen: String, data: String) {
        // Создаем URL для Flutter приложения с параметрами screen и data
        let urlString = "revive://app?data=\(data)&screen=\(screen)"
        
        // Кодируем URL для обработки специальных символов
        if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let flutterAppURL = URL(string: encodedString) {
            
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
}

#Preview {
    ContentView()
}
