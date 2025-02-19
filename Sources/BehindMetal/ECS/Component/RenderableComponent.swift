//
//  RenderableComponent.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//

import BehindECS

class RenderComponent: BComponent {
    var renderable: Renderable
    
    init(renderable: Renderable) {
        self.renderable = renderable
    }
}
