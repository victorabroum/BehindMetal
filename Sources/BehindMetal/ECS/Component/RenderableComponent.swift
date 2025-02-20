//
//  RenderableComponent.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//

import BehindECS

public class RenderComponent: BComponent {
    public var renderable: Renderable
    
    public init(renderable: Renderable) {
        self.renderable = renderable
    }
}
