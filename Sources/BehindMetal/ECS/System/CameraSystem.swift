//
//  CameraSystem.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//


import MetalKit
import BehindECS

open class CameraSystem: BBaseSystem {
    
    var scene: SceneController

    public init(entityManager: BEntityManager, scene: SceneController) {
        self.scene = scene
        super.init(entityManager: entityManager)
    }
    
    open override func render(commandEncoder: any MTLRenderCommandEncoder, deltaTime: Float) {
        let entities = entityManager.getEntitiesWithBComponent(ofType: CameraComponent.self)
        for entity in entities {
            if let cameraComp = entityManager.getComponent(ofType: CameraComponent.self, from: entity),
               cameraComp.isActive {
                
                cameraComp.rotation.y += 0.01
                
                scene.sceneConstants.projectionMatrix = cameraComp.projectionMatrix
                scene.sceneConstants.viewMatrix = cameraComp.viewMatrix
            }
        }
    }
    
    func setActive(camera: BEntity) {
        let entities = entityManager.getEntitiesWithBComponent(ofType: CameraComponent.self)
        for entity in entities {
            if let cameraComp = entityManager.getComponent(ofType: CameraComponent.self, from: entity) {
                cameraComp.isActive = (entity == camera)
            }
        }
        
    }
}
