//
//  TabPostion.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 01.07.24.
//

import SwiftUI

struct PostionKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func viewPostion(completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let rect  = $0.frame(in: .global)
                    
                    Color.clear
                        .preference(key: PostionKey.self, value: rect)
                        .onPreferenceChange(PostionKey.self, perform: completion)
                }
            }
    }
}
