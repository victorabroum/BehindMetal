//
//  CameraComponent.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//


import simd
import BehindECS

open class CameraComponent: BComponent {
    
    public var position: SIMD3<Float> = .zero
    public var scale: SIMD3<Float> = SIMD3<Float>(1, 1, 1)
    public var rotation: SIMD3<Float> = SIMD3<Float>(0, 0, 0)
    
    var viewMatrix: simd_float4x4 {
        var result = matrix_identity_float4x4
        
        result.translate(direction: -position)
        
        result.scale(axis: scale)
        
        result.rotate(angle: rotation.x, axis: .xAxis)
        result.rotate(angle: rotation.y, axis: .yAxis)
        result.rotate(angle: rotation.z, axis: .zAxis)
        
        return result
    }
    
    public var fov: Float = 45
    public var aspect: Float = 16/9
    public var near: Float = 0.1
    public var far: Float = 100
    
    public var projectionMatrix: matrix_float4x4 {
        return matrix_float4x4.perspective(degreesFov: fov, aspectRatio: aspect, near: near, far: far)
    }
    
    public var isActive: Bool = false
}
