//
//  Renderable.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//


import MetalKit

protocol Renderable {
    func draw(commandEncoder: MTLRenderCommandEncoder)
}
