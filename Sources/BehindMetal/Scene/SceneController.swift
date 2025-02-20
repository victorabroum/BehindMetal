//
//  SceneController.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//


import MetalKit
import BehindECS

open class SceneController {
    
    open var sceneConstants = SceneConstants()
    
    public var systems: [BSystem] = []
    
    public var entityManager = BEntityManager()
    
    public init() {
        setupRenderSystem()
        setupDefaultCameraSystem()
        sceneDidLoad()
    }
    
    open func sceneDidLoad() { }
    
    open func didMove() { }
    
    private func setupDefaultCameraSystem() {
        let cameraComp = CameraComponent()
        cameraComp.isActive = true
        cameraComp.position.z = 10
        let camera = entityManager.createEntity()
        entityManager.addComponent(to: camera, cameraComp)
        
        let cameraSystem = CameraSystem(entityManager: entityManager, scene: self)
        systems.append(cameraSystem)
    }
    
    private func setupRenderSystem() {
        systems.append(RenderSystem(entityManager: entityManager))
    }
}

extension SceneController: SceneRendererDelegate {
    public func render(commandEncoder: MTLRenderCommandEncoder, atTime time: Float) {
        
        sceneConstants.timeElapsed += time
        
        commandEncoder.setVertexBytes(&sceneConstants, length: SceneConstants.stride, index: 1)
        commandEncoder.setFragmentBytes(&sceneConstants, length: SceneConstants.stride, index: 1)
        
        for system in self.systems {
            system.render(commandEncoder: commandEncoder, deltaTime: time)
        }
    }
}
