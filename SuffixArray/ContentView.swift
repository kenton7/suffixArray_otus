//
//  ContentView.swift
//  SuffixArray
//
//  Created by Илья Кузнецов on 14.04.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var textForTextField = ""
    @State private var selectedTab = 0
    @State private var isShowing = false
    @State var suffixArray = [Substring]()
    @State var allSuffixes = [Substring]()
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack {
                Spacer()
                TextField("Введите текст или слово", text: $textForTextField)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                Button(action: {
                    isShowing = true
                    allSuffixes += SuffixSequence(word: textForTextField).map {$0}.sorted()
                    suffixArray = SuffixSequence(word: textForTextField).map {$0}.sorted()
                }, label: {
                    HStack {
                        Text("Проверить суффиксный массив")
                    }
                })
                Spacer()
                .tabItem { Label(
                    title: { Text("Suffix Array") },
                    icon: { Image(systemName: "house.circle.fill") }
                ) }
                    
                Text("\(suffixArray)")
                Spacer()
            }.tag(0)
                .tabItem { Label(
                    title: { Text("Suffix Array") },
                    icon: { Image(systemName: "house.circle.fill") } )
                }
            
            
            StatisticScreen(suffixArray: allSuffixes, searchingWord: textForTextField).tag(1)
                .tabItem { Label("Статистика", systemImage: "chart.pie.fill") }
        }
    }
}

