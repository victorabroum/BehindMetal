//
//  LightSystem.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 20/02/25.
//

import BehindECS
import MetalKit

public class LightSystem: BBaseSystem {
    
    public override func render(commandEncoder: any MTLRenderCommandEncoder, deltaTime: Float) {
        let entities = entityManager.getEntitiesWithBComponent(ofType: LightComponent.self)
        
        for entity in entities {
            
            drawDebug(for: entity, commandEncoder: commandEncoder)
            
            if let lightComp = entityManager.getComponent(ofType: LightComponent.self, from: entity) {
                let newLightData = LightData(withComponent: lightComp)
                
                if let index = lightComp.sceneController?.lights.firstIndex(where: { $0.id == lightComp.id }) {
                    lightComp.sceneController?.lights[index] = newLightData
                }
            }
        }
    }
    
    private func drawDebug(for entity: BEntity, commandEncoder: any MTLRenderCommandEncoder) {
        if let transformComp = entityManager.getComponent(ofType: TransformComponent.self, from: entity),
           let lightComp = entityManager.getComponent(ofType: LightComponent.self, from: entity){
            
            transformComp.position = lightComp.position
        }
    }
    
}
