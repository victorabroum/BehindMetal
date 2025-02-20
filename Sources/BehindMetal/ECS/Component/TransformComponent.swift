//
//  TransformComponent.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//

import MetalKit
import BehindECS

open class TransformComponent: BComponent {
    public var position: SIMD3<Float> = .zero {
        didSet {
            updateModelConstant()
        }
    }
    public var scale: SIMD3<Float> = SIMD3<Float>(1, 1, 1) {
        didSet {
            updateModelConstant()
        }
    }
    public var rotation: SIMD3<Float> = SIMD3<Float>(0, 0, 0) {
        didSet {
            updateModelConstant()
        }
    }
    
    public init() { } 
    
    public var modelMatrix: simd_float4x4 {
        var result = matrix_identity_float4x4
        
        result.translate(direction: position)
        
        result.scale(axis: scale)
        
        result.rotate(angle: rotation.x, axis: .xAxis)
        result.rotate(angle: rotation.y, axis: .yAxis)
        result.rotate(angle: rotation.z, axis: .zAxis)
        
        return result
    }
    
    public var modelConstant: ModelConstants = ModelConstants()
    
    public func updateModelConstant() {
        modelConstant.modelMatrix = modelMatrix
    }
    
    open func setScale(_ value: Float) {
        scale = .init(value, value, value)
    }
}
