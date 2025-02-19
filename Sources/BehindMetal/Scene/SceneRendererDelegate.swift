//
//  SceneRendererDelegate.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//


import MetalKit

public protocol SceneRendererDelegate {
    func render(commandEncoder: MTLRenderCommandEncoder, atTime time: Float)
}
