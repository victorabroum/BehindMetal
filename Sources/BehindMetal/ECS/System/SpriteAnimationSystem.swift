//
//  SpriteAnimationSystem.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//

import BehindECS
import MetalKit

public class SpriteAnimationSystem: BBaseSystem {
    public override func render(commandEncoder: any MTLRenderCommandEncoder, deltaTime: Float) {
        
        let entities = entityManager.getEntitiesWithBComponent(ofType: SpriteAnimationComponent.self)
        
        for entity in entities {
            if let spriteComp = entityManager.getComponent(ofType: SpriteAnimationComponent.self, from: entity),
               let spriteMesh = entityManager.getComponent(ofType: RenderComponent.self, from: entity)?.renderable as? SpriteMesh {
                
                spriteComp.elapsedTime += deltaTime
                if spriteComp.elapsedTime >= spriteComp.frameTime {
                    spriteComp.elapsedTime = 0
                    spriteComp.currentFrame = (spriteComp.currentFrame + 1) % spriteComp.frameCount
                    
                    spriteMesh.updateFrame(frameIndex: spriteComp.currentFrame)
                }
                
            }
        }
        
    }
}
