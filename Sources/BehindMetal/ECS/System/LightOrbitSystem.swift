//
//  LightOrbitSystem.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 21/02/25.
//

import BehindECS
import MetalKit

public class LightOrbitSystem: BBaseSystem {
    
    var time: Float = 0
    
    public override func render(commandEncoder: any MTLRenderCommandEncoder, deltaTime: Float) {
        let entities = entityManager.getEntitiesWithBComponent(ofType: LightComponent.self)
        
        for entity in entities {            
            if let lightComp = entityManager.getComponent(ofType: LightComponent.self, from: entity),
               let orbitComp = entityManager.getComponent(ofType: OrbitComponent.self, from: entity){
                
                time += deltaTime
                
                lightComp.position.x = sin(time * orbitComp.speed) * orbitComp.radius + orbitComp.centeredAt.x
                lightComp.position.y = cos(time * orbitComp.speed) * orbitComp.radius + orbitComp.centeredAt.y

            }
        }
    }
    
}
