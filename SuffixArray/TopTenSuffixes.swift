//
//  TopTenSuffixes.swift
//  SuffixArray
//
//  Created by Илья Кузнецов on 18.04.2024.
//

import SwiftUI

struct TopTenSuffixes: View {
    
    var topTen: [(key: Substring, value: Int)]
    
    var body: some View {
        VStack {
            List {
                ForEach(topTen, id: \.key) {
                    Text("\($0) - \($1)")
                }
            }
        }
    }
}

#Preview {
    TopTenSuffixes(topTen: [(key: "бра", value: 10)])
}
