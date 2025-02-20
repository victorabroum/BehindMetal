//
//  Material.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//

import MetalKit

public class Material {
    public let texture: MTLTexture
    
    public var color: MTLClearColor = MTLClearColor(red: 1, green: 1, blue: 1, alpha: 1)

    init(texture: MTLTexture) {
        self.texture = texture
    }
    
    public init(textureNamed: String) {
        self.texture = Texture.loadTexture(named: textureNamed)
    }
    
    public init(color: MTLClearColor) {
        self.color = color
        self.texture = Texture.createEmptyTexture()
    }
}
