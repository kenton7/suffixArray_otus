//
//  StatisticScreen.swift
//  SuffixArray
//
//  Created by Илья Кузнецов on 15.04.2024.
//

import SwiftUI
import Combine

struct StatisticScreen: View {
    
    var suffixArray: [Substring]
    @State private var selectedTab = 0
    @State private var isSortingPressed = false
    @State var suffixesDict: [Substring: Int] = [:]
    @State var suffixAndExecutionTime: [String: String] = [:]
    @State var allSuffixesAndExecutionTimes: [[String: String]] = [[:]]
    @State private var previousSuffixArray: [Substring] = []
    private let jobScheduler = JobScheduler()
    var searchingWord: String
    
    var sortedPairs: [(key: Substring, value: Int)] {
        return isSortingPressed ? suffixesDict.sorted(by: { $0.key < $1.key }) : suffixesDict.sorted(by: { $1.key < $0.key })
    }
    
    var topTen: [(key: Substring, value: Int)] {
        let filteredSortedPairs = sortedPairs.filter { $0.key.count >= 3 }.sorted { $0.value > $1.value }
        return Array(filteredSortedPairs.prefix(10))
    }

    var body: some View {
        
        VStack {
            Picker("", selection: $selectedTab) {
                Text("Статистика").tag(0)
                Text("Топ-10").tag(1)
                Text("История").tag(2)
            }.pickerStyle(.segmented)
                .padding()
            
            
            TabView(selection: $selectedTab) {
                VStack {
                    Text("Суффиксы >= 3 символов")
                    List {
                        ForEach(sortedPairs.filter { $0.key.count >= 3 }, id: \.key) { (suffix, count) in
                            Text("\(suffix) - \(count)")
                        }
                    }
                    Button(isSortingPressed ? "Sort to DESC" : "Sort to ASC") {
                        isSortingPressed.toggle()
                    }
                }.tag(0)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                
                TopTenSuffixes(topTen: topTen).tag(1)
                
                SearchHistoryScreen(suffixes: allSuffixesAndExecutionTimes).tag(2)
                    .task {
                        allSuffixesAndExecutionTimes.append(await jobScheduler.newSearch(text: searchingWord))
                        await jobScheduler.start()
                    }
            }
        }
        .onChange(of: suffixArray, { _, newValue in
            if newValue != previousSuffixArray {
                suffixesDict.removeAll() // Очищаем словарь
                newValue.forEach { suffixesDict[$0, default: 0] += 1 } // Пересчитываем суффиксы
                previousSuffixArray = newValue // Обновляем предыдущее значение
            }
        })
        .onDisappear {
            isSortingPressed = false
        }
    }
}
