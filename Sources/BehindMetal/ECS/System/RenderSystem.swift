//
//  RenderSystem.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//

import BehindECS
import MetalKit

class RenderSystem: BBaseSystem {
    override func render(commandEncoder: any MTLRenderCommandEncoder, deltaTime: Float) {
        let entities = entityManager.getEntitiesWithBComponent(ofType: RenderComponent.self)
        
        for entity in entities {
            if let renderComp = entityManager.getComponent(ofType: RenderComponent.self, from: entity),
               let transformComp = entityManager.getComponent(ofType: TransformComponent.self, from: entity) {
                commandEncoder.setVertexBytes(&transformComp.modelConstant, length: ModelConstants.size, index: 2)
                
                renderComp.renderable.draw(commandEncoder: commandEncoder)
                
            }
        }
    }
}
