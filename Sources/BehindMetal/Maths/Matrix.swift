//
//  Matrix.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//


import simd

extension matrix_float4x4 {
    
    mutating func translate(direction: SIMD3<Float>) {
        var result = matrix_identity_float4x4
        
        let x = direction.x
        let y = direction.y
        let z = direction.z
        
        result.columns = (
            SIMD4<Float>(1, 0, 0, 0),
            SIMD4<Float>(0, 1, 0, 0),
            SIMD4<Float>(0, 0, 1, 0),
            SIMD4<Float>(x, y, z, 1)
        )
        
        self = matrix_multiply(self, result)
    }
    
    mutating func scale(axis: SIMD3<Float>) {
        var result = matrix_identity_float4x4
        
        let x = axis.x
        let y = axis.y
        let z = axis.z
        
        result.columns = (
            SIMD4<Float>(x, 0, 0, 0),
            SIMD4<Float>(0, y, 0, 0),
            SIMD4<Float>(0, 0, z, 0),
            SIMD4<Float>(0, 0, 0, 1)
        )
        
        self = matrix_multiply(self, result)
    }
    
    mutating func rotate(angle: Float, axis: SIMD3<Float>){
        var result = matrix_identity_float4x4
        
        let x: Float = axis.x
        let y: Float = axis.y
        let z: Float = axis.z
        
        let cosAngle: Float = cos(angle)
        let sinAngle: Float = sin(angle)
        
        let mc: Float = (1 - cosAngle)
        
        let r1c1: Float = x * x * mc + cosAngle
        let r2c1: Float = x * y * mc + z * sinAngle
        let r3c1: Float = x * z * mc - y * sinAngle
        let r4c1: Float = 0.0
        
        let r1c2: Float = y * x * mc - z * sinAngle
        let r2c2: Float = y * y * mc + cosAngle
        let r3c2: Float = y * z * mc + x * sinAngle
        let r4c2: Float = 0.0
        
        let r1c3: Float = z * x * mc + y * sinAngle
        let r2c3: Float = z * y * mc - x * sinAngle
        let r3c3: Float = z * z * mc + cosAngle
        let r4c3: Float = 0.0
        
        let r1c4: Float = 0.0
        let r2c4: Float = 0.0
        let r3c4: Float = 0.0
        let r4c4: Float = 1.0
        
        result.columns = (
            SIMD4<Float>(r1c1, r2c1, r3c1, r4c1),
            SIMD4<Float>(r1c2, r2c2, r3c2, r4c2),
            SIMD4<Float>(r1c3, r2c3, r3c3, r4c3),
            SIMD4<Float>(r1c4, r2c4, r3c4, r4c4)
        )
        
        self = matrix_multiply(self, result)
    }
    
    static func perspective(degreesFov: Float, aspectRatio: Float, near: Float, far: Float)->matrix_float4x4{
        let fov = degreesFov.toRadians;
        
        let yScale = 1 / tan(fov * 0.5)
        let xScale = yScale / aspectRatio
        let zRange = far - near
        let zScale = -(far + near) / zRange
        let wzScale = -2 * far * near / zRange

        return matrix_float4x4(columns: (
            SIMD4<Float>(xScale, 0, 0, 0),
            SIMD4<Float>(0, yScale, 0, 0),
            SIMD4<Float>(0, 0, zScale, -1),
            SIMD4<Float>(0, 0, wzScale, 0)
        ))
    }
}
