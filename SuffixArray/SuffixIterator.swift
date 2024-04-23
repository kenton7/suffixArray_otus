//
//  SuffixIterator.swift
//  SuffixArray
//
//  Created by Илья Кузнецов on 14.04.2024.
//

import Foundation

struct SuffixSequence: Sequence {
    
    private let word: String
    
    init(word: String) {
        self.word = word
    }
    
    func makeIterator() -> SuffixIterator {
        return SuffixIterator(word: word)
    }
}

struct SuffixIterator: IteratorProtocol {
    
    private let word: String
    private var suffixCounts: [Substring: Int]
    private var currentIndex: String.Index
    
    init(word: String) {
        self.word = word
        self.currentIndex = word.startIndex
        self.suffixCounts = [:]
    }
    
    mutating func next() -> Substring? {
        guard currentIndex < word.endIndex else { return nil }
        defer { currentIndex = word.index(after: currentIndex) }
        let suffix = word[currentIndex..<word.endIndex]
        suffixCounts[suffix, default: 0] += 1
        return suffix
    }
    
    func count() -> [Substring: Int] {
        return suffixCounts
    }
}

extension Array {
    func getRandomID() -> String {
        UUID().uuidString
    }
}

//struct SuffixIterator: IteratorProtocol {
//    private let word: String
//    private var currentIndex: String.Index
//    private var suffixCounts: [Substring: Int]
//
//    init(word: String) {
//        self.word = word
//        self.currentIndex = word.startIndex
//        self.suffixCounts = [:]
//    }
//
//    mutating func next() -> Substring? {
//        guard currentIndex < word.endIndex else { return nil }
//        defer { currentIndex = word.index(after: currentIndex) }
//        let suffix = word[currentIndex..<word.endIndex]
//        suffixCounts[suffix, default: 0] += 1
//        return suffix
//    }
//
//    func count() -> [Substring: Int] {
//        return suffixCounts
//    }
//}

