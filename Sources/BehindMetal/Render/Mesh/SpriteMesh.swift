//
//  SpriteMesh.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//


import MetalKit

open class SpriteMesh: Mesh {
    
    private static let i: Float = 1
    
    private var uvOffset: SIMD2<Float> = SIMD2<Float>(0, 0)
    private var uvSize: SIMD2<Float> = SIMD2<Float>(1, 1)
    private let columns: Int
    
    private var textureAspectRatio: Float
    
    public init(imageNamed: String, columns: Int = 1, rows: Int = 1) {
        self.columns = columns
        
        let material = Material(textureNamed: imageNamed)
        
        let textureSize: CGSize = .init(width: material.texture.width,
                                        height: material.texture.height)
        
        textureAspectRatio = Float((textureSize.width / CGFloat(columns)) / (textureSize.height / CGFloat(rows)))
        
        uvSize = SIMD2<Float>(1.0 / Float(columns), 1.0 / Float(rows))
        
        // Definir os vértices e coordenadas de textura
        let vertices = SpriteMesh.createVertices(aspectRatio: textureAspectRatio, uvOffset: uvOffset, uvSize: uvSize)
        let indices: [UInt32] = [
            0, 1, 2, 0, 3, 2,
        ]
        
        let device = MetalContext.shared.device
        
        guard let pipelineState = RenderPipelineStateLibrary.createDefault2D() else {
            fatalError("Couldn't create Default 2D pipeline state")
            return
        }
        
        super.init(material: material,
                   vertexBuffer: device.makeBuffer(bytes: vertices, length: vertices.stride)!,
                   indexBuffer: device.makeBuffer(bytes: indices, length: indices.stride),
                   vertexCount: vertices.count,
                   indexCount: indices.count,
                   renderPipelineState: pipelineState)
        
        updateFrame(frameIndex: 0)
    }
    
    open override func draw(commandEncoder: any MTLRenderCommandEncoder) {
        super.draw(commandEncoder: commandEncoder)
    }
    
    
    func updateFrame(frameIndex: Int) {
        let column = frameIndex % columns
        let row = frameIndex / columns
        uvOffset = SIMD2<Float>(Float(column) * uvSize.x, Float(row) * uvSize.y)
        
        let newVertices = SpriteMesh.createVertices(aspectRatio: textureAspectRatio, uvOffset: uvOffset, uvSize: uvSize)
        vertexBuffer.contents().copyMemory(from: newVertices, byteCount: newVertices.stride)
    }
    
    func updateFrame(frameIndex: Int, commandEnconder: MTLCommandEncoder) {
        let column = frameIndex % columns
        let row = frameIndex / columns
        uvOffset = SIMD2<Float>(Float(column) * uvSize.x, Float(row) * uvSize.y)
        
        let newVertices = SpriteMesh.createVertices(aspectRatio: textureAspectRatio, uvOffset: uvOffset, uvSize: uvSize)
        vertexBuffer.contents().copyMemory(from: newVertices, byteCount: newVertices.stride)
    }
    
    private static func createVertices(aspectRatio: Float, uvOffset: SIMD2<Float>, uvSize: SIMD2<Float>) -> [Vertex] {
        return [
            Vertex(position: SIMD3<Float>(-i * aspectRatio, -i, 0),
                   texCoord: uvOffset + SIMD2<Float>(0, uvSize.y)),
            
            Vertex(position: SIMD3<Float>( i * aspectRatio, -i, 0),
                   texCoord: uvOffset + SIMD2<Float>(uvSize.x, uvSize.y)),
            
            Vertex(position: SIMD3<Float>( i * aspectRatio,  i, 0),
                   texCoord: uvOffset + SIMD2<Float>(uvSize.x, 0)),
            
            Vertex(position: SIMD3<Float>(-i * aspectRatio,  i, 0),
                   texCoord: uvOffset + SIMD2<Float>(0, 0)),
        ]
    }
}
