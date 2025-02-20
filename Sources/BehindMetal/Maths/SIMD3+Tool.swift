//
//  SIMD3+Tool.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//

import simd

public extension SIMD3 where Scalar == Float {
    static func random(in range: ClosedRange<Scalar>) -> Self {
        return .init(
            x: .random(in: range),
            y: .random(in: range),
            z: .random(in: range)
        )
    }
}
