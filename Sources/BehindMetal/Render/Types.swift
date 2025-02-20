//
//  Types.swift
//  BehindGameEngine
//
//  Created by Victor Vasconcelos on 19/02/25.
//

import simd

public protocol Sizeable {
    static func size(_ count: Int)->Int
    static func stride(_ count: Int)->Int
}

public extension Sizeable {
    static var size: Int {
        return MemoryLayout<Self>.size
    }
    
    static var stride: Int {
        return MemoryLayout<Self>.stride
    }
    
    static func size(_ count: Int)->Int{
        return MemoryLayout<Self>.size * count
    }
    
    static func stride(_ count: Int)->Int{
        return MemoryLayout<Self>.stride * count
    }
}

public struct Vertex: Sizeable {
    var position: SIMD3<Float>
    var texCoord: SIMD2<Float>
    var color: SIMD4<Float> = .one
    var uvNormal: SIMD3<Float> = .init(0, 0, 1)
}

extension SIMD3: Sizeable { }
extension SIMD2: Sizeable { }
extension SIMD4: Sizeable { }
extension Float: Sizeable { }
extension UInt32: Sizeable { }

public struct ModelConstants: Sizeable {
    var modelMatrix = matrix_identity_float4x4
}

public struct SceneConstants: Sizeable {
    var viewMatrix = matrix_identity_float4x4
    var projectionMatrix = matrix_identity_float4x4
    
    var timeElapsed: Float = 0
}

public extension SIMD3 where Scalar == Float {
    static var xAxis: SIMD3<Float> { .init(1, 0, 0) }
    static var yAxis: SIMD3<Float> { .init(0, 1, 0) }
    static var zAxis: SIMD3<Float> { .init(0, 0, 1) }
}

public extension Array where Element: Sizeable {
    var size: Int {
        return MemoryLayout<Element>.size * count
    }
    
    var stride: Int {
        return MemoryLayout<Element>.stride * count
    }
}
