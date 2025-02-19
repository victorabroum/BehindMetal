//
//  TransformComponent.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//

import MetalKit
import BehindECS

class TransformComponent: BComponent {
    var position: SIMD3<Float> = .zero {
        didSet {
            updateModelConstant()
        }
    }
    var scale: SIMD3<Float> = SIMD3<Float>(1, 1, 1) {
        didSet {
            updateModelConstant()
        }
    }
    var rotation: SIMD3<Float> = SIMD3<Float>(0, 0, 0) {
        didSet {
            updateModelConstant()
        }
    }
    
    var modelMatrix: simd_float4x4 {
        var result = matrix_identity_float4x4
        
        result.translate(direction: position)
        
        result.scale(axis: scale)
        
        result.rotate(angle: rotation.x, axis: .xAxis)
        result.rotate(angle: rotation.y, axis: .yAxis)
        result.rotate(angle: rotation.z, axis: .zAxis)
        
        return result
    }
    
    var modelConstant: ModelConstants = ModelConstants()
    
    func updateModelConstant() {
        modelConstant.modelMatrix = modelMatrix
    }
    
    func setScale(_ value: Float) {
        scale = .init(value, value, value)
    }
}
