//
//  ContentView.swift
//  SuffixArray
//
//  Created by Илья Кузнецов on 14.04.2024.
//

import SwiftUI

struct ContentView: View {
    
    private let exampleText = "Абракадабра"
    @State private var textForTextField = ""
    @State private var selectedTab = 0
    @State private var isPresented = false
    @State private var isShowing = false
    @State var suffixArray = [Substring]()
    @State var allSuffixes = [Substring]()
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
//            ExtractedView(textForTextField: $textForTextField).tag(0)
//                .tabItem { Label(
//                    title: { Text("Suffix Array") },
//                    icon: { Image(systemName: "house.circle.fill") } )
//                }
            VStack {
                Spacer()
                TextField("Введите текст или слово", text: $textForTextField)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                Button(action: {
                    isShowing = true
                    allSuffixes += SuffixSequence(word: textForTextField).map {$0}.sorted()
                    suffixArray = SuffixSequence(word: textForTextField).map {$0}.sorted()
                    textForTextField = ""
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
            
            
            StatisticScreen(suffixArray: allSuffixes).tag(1)
                .tabItem { Label("Статистика", systemImage: "chart.pie.fill") }
        }
    }
}

//#Preview {
//    ContentView()
//}

struct ExtractedView: View {
    
    var exampleText = "Абракадабра"
    @Binding var textForTextField: String
    @State private var isShowing = false
    @State var suffixArray = [Substring]()
    @State var allSuffixes = [Substring]()
    
    var body: some View {
        VStack {
            TextField("Или введите своё слово", text: $textForTextField)
                .padding()
                .textFieldStyle(.roundedBorder)
            
            Button(action: {
                isShowing = true
                allSuffixes += SuffixSequence(word: textForTextField).map {$0}.sorted()
                suffixArray = SuffixSequence(word: textForTextField).map {$0}.sorted()
                print(suffixArray)
                print(allSuffixes)
                textForTextField = ""
            }, label: {
                HStack {
                    Text("Проверить суффиксный массив")
                }
            })
                
            
//            Text("Суффиксиный массив для слова \(textForTextField):").font(.title).bold()
            Text("\(suffixArray)")
            //Text("\(SuffixSequence(word: textForTextField).map { $0 }.sorted())")
            Spacer()
        }
    }
}
