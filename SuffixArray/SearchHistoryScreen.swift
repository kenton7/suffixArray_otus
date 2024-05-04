//
//  SearchHistoryScreen.swift
//  SuffixArray
//
//  Created by Илья Кузнецов on 29.04.2024.
//

import SwiftUI

struct SearchHistoryScreen: View {
    
    private let jobScheduler = JobScheduler()
    var suffixes: [[String: String]]
    
    
    var body: some View {
            List {
                let allExecutionTimes = suffixes.flatMap { $0.values.map { Double($0) ?? 0 } }
                let minExecutionTime = allExecutionTimes.min() ?? 0
                let maxExecutionTime = allExecutionTimes.max() ?? 0
                
                ForEach(suffixes, id: \.self) { dict in
                    ForEach(dict.sorted(by: <), id: \.key) {
                        let executionTime = Double($1) ?? 0
                        Text("Суффикс \"\($0)\" найден за \($1) секунд")
                            .background(Rectangle().fill(executionTime == minExecutionTime ? .green : .clear))
                            .background(Rectangle().fill(executionTime == maxExecutionTime ? .red : .clear))
                    }
                }
            }
    }
}
