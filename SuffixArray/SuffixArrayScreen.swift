//
//  SuffixArrayScreen.swift
//  SuffixArray
//
//  Created by Илья Кузнецов on 15.04.2024.
//

import SwiftUI

struct SuffixArrayScreen: View {
    
    private let exampleText = "привет как дела?"
    @State private var textForTextField = ""
    
    var body: some View {
        VStack {
            Text("Пример суффиксного массива для слова \"Абракадабра\"")
                .padding()
                .multilineTextAlignment(.center)
                .font(.title)
                .foregroundStyle(.white)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.indigo))
            Text("\(SuffixSequence(word: exampleText).map { $0 }.sorted())")
                .padding()
                .multilineTextAlignment(.center)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.green))
            Text(exampleText)
                .padding()
                .multilineTextAlignment(.center)
            TextField("Или введите своё слово", text: $textForTextField)
                .padding()
                .textFieldStyle(.roundedBorder)
            
            Text("Суффиксиный массив для слова \(textForTextField):").font(.title).bold()
            Text("\(SuffixSequence(word: textForTextField.lowercased()).map { $0 }.sorted())")
            Spacer()
        }
    }
}

//#Preview {
//    SuffixArrayScreen()
//}
