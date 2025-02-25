//
//  SceneController.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//


import MetalKit
import BehindECS

open class SceneController: Sizeable {
    
    open var sceneConstants = SceneConstants()
    
    public var systems: [BSystem] = []
    
    public var lights: [LightData] = Array(repeating: LightData(withComponent: LightComponent()), count: 8)
    
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
        systems.append(LightOrbitSystem(entityManager: entityManager))
        systems.append(LightSystem(entityManager: entityManager))
        systems.append(RenderSystem(entityManager: entityManager))
    }
    
    public func canAddLight() -> Bool {
        return lights.firstIndex(where: { $0.isActive == 0 }) != nil
    }
    
    public func addLight(_ lightComp: LightComponent) {
        guard canAddLight() else {
            print("Cound not add light because we are full! The max amount is 8 lights")
            return
        }
        if let emptySpaceIndex = lights.firstIndex(where: { $0.isActive == 0 }) {
            lights[emptySpaceIndex] = LightData(withComponent: lightComp)
        }
    }
}

extension SceneController: SceneRendererDelegate {
    public func render(commandEncoder: MTLRenderCommandEncoder, atTime time: Float) {
        
        sceneConstants.timeElapsed += time
        
        commandEncoder.setVertexBytes(&sceneConstants,
                                      length: SceneConstants.stride,
                                      index: 1)
        commandEncoder.setFragmentBytes(&lights,
                                        length: lights.stride,
                                        index: 1)
        
        for system in self.systems {
            system.render(commandEncoder: commandEncoder, deltaTime: time)
        }
    }
}
