//
//  LightSystem.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 20/02/25.
//

import BehindECS
import MetalKit

public class LightSystem: BBaseSystem {
    
    var time: Float = 0
    
    public override func render(commandEncoder: any MTLRenderCommandEncoder, deltaTime: Float) {
        let entities = entityManager.getEntitiesWithBComponent(ofType: LightComponent.self)
        
        for entity in entities {
            if let lightComp = entityManager.getComponent(ofType: LightComponent.self, from: entity) {
                
                time += deltaTime
                
                lightComp.position.y = sin(time * 0.5) * 10
                
                let newLightData = LightData(withComponent: lightComp)
                
                if let index = lightComp.sceneController?.lights.firstIndex(where: { $0.id == lightComp.id }) {
                    lightComp.sceneController?.lights[index] = newLightData
                }
            }
        }
    }
    
}
