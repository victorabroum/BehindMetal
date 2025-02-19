//
//  SceneController.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//


import MetalKit

public class SceneController {
    
    public var sceneConstants = SceneConstants()
    
    init() {
        sceneDidLoad()
    }
    
    func sceneDidLoad() { }
    
    func didMove() { }
}

extension SceneController: SceneRendererDelegate {
    public func render(commandEncoder: MTLRenderCommandEncoder, atTime time: Float) {
        commandEncoder.setVertexBytes(&sceneConstants, length: SceneConstants.stride, index: 1)
    }
}
