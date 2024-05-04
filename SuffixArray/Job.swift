//
//  Job.swift
//  SuffixArray
//
//  Created by Илья Кузнецов on 29.04.2024.
//

import Foundation

struct Job {
    let searchText: String
    let jobScheduler: JobScheduler
    var dataDict: [String: String] = [:]
    
    mutating func performTask() async -> [String: String] {
        let startTime = Date()
        let suffix = SuffixSequence(word: searchText).map { String($0) }
        let endTime = Date()

        let executionTime = String(format: "%.9f", endTime.timeIntervalSince(startTime))
        suffix.forEach { dataDict[String($0)] = executionTime }
        return dataDict
    }
    
    func searchSuffixes(text: String) async -> [String: String] {
        let words = text.components(separatedBy: " ")
        var suffixes: [String] = []
        var suffixesAndTime: [String: String] = [:]
        for word in words {
            let startTime = Date()
            for i in 0..<word.count {
                let suffix = String(word.suffix(from: word.index(word.startIndex, offsetBy: i)))
                suffixes.append(String(word.suffix(from: word.index(word.startIndex, offsetBy: i))))
                let endTime = Date()
                let executionTime = String(format: "%.9f", endTime.timeIntervalSince(startTime))
                print("Суффикс \(suffix) найден за \(executionTime) секунд")
                suffixesAndTime[suffix] = executionTime
            }
        }
        return suffixesAndTime
    }
}

struct JobQueue {
    var jobs: [Job] = []
    
    mutating func add(job: Job) {
        jobs.append(job)
    }
}
