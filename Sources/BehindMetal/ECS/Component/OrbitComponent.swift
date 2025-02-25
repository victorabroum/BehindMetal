//
//  LightOrbitComponent.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 21/02/25.
//

import BehindECS

public class OrbitComponent: BComponent {
    public var centeredAt: SIMD3<Float> = .zero
    public var radius: Float
    public var speed: Float
    
    public init(centeredAt: SIMD3<Float>, radius: Float, speed: Float) {
        self.centeredAt = centeredAt
        self.radius = radius
        self.speed = speed
    }
}
