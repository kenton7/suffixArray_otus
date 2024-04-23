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
    @State private var previousSuffixArray: [Substring] = []
    @State var searchQuery = ""
    
    var sortedPairs: [(key: Substring, value: Int)] {
        return isSortingPressed ? suffixesDict.sorted(by: { $0.key < $1.key }) : suffixesDict.sorted(by: { $1.key < $0.key })
    }
    
    var topTen: [(key: Substring, value: Int)] {
        let filteredSortedPairs = sortedPairs.filter { $0.key.count >= 3 }.sorted { $0.value > $1.value }
        return Array(filteredSortedPairs.prefix(10))
    }
    
    init(suffixArray: [Substring]) {
        self.suffixArray = suffixArray
    }
    
    
    var body: some View {
        
        VStack {
            Picker("", selection: $selectedTab) {
                Text("Статистика").tag(0)
                Text("Топ-10 суффиксов").tag(1)
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


//#Preview {
//    StatisticScreen(suffixArray: SuffixSequence(word: "абракадабра").map {$0}.sorted(), word: "абракадабра")
//}
