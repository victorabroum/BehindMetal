//
//  Mesh.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//


import MetalKit

open class Mesh: Renderable {
    
    public let material: Material
    
    public var vertexBuffer: MTLBuffer
    public var vertexCount: Int
    
    public var indexBuffer: MTLBuffer?
    public var indexCount: Int?
    
    public var piplelineState: MTLRenderPipelineState
    
    public init(material: Material,
         vertexBuffer: MTLBuffer,
         indexBuffer: MTLBuffer? = nil,
         vertexCount: Int,
         indexCount: Int,
                renderPipelineState: MTLRenderPipelineState) {
        self.material = material
        self.vertexBuffer = vertexBuffer
        self.indexBuffer = indexBuffer
        self.vertexCount = vertexCount
        self.indexCount = indexCount
        self.piplelineState = renderPipelineState
    }
    
    open func draw(commandEncoder: any MTLRenderCommandEncoder) {
        commandEncoder.setRenderPipelineState(piplelineState)
        commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        commandEncoder.setFragmentTexture(material.texture, index: 0)
        
        if let indexBuffer, let indexCount {
            commandEncoder.drawIndexedPrimitives(type: .triangle, indexCount: indexCount, indexType: .uint32, indexBuffer: indexBuffer, indexBufferOffset: 0)
        } else {
            commandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount)
        }
        
    }
    
    
    open func updateBuffers(with vertices: [Vertex]) {
        vertexBuffer = MetalContext.shared.device.makeBuffer(bytes: vertices, length: vertices.stride)!
    }
}
