//
//  Float.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//


extension Float {
    static func toRadians(_ degrees: Float) -> Float {
        return degrees * .pi / 180
    }
    
    var toRadians: Float{
        return (self / 180.0) * Float.pi
    }
    
    var toDegrees: Float{
        return self * (180.0 / Float.pi)
    }
}
