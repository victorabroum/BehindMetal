//
//  QuadMesh.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 21/02/25.
//

import MetalKit

open class QuadMesh: Mesh {
    
    public init(color: SIMD4<Float>) {
        let vertices: [Vertex] = [
            Vertex(position: SIMD3<Float>(-1, -1, 0),
                   texCoord: SIMD2<Float>(0, 1),
                   color: color), // Bottom-left
            
            Vertex(position: SIMD3<Float>( 1, -1, 0),
                   texCoord: SIMD2<Float>(1, 1),
                   color: color), // Bottom-right
            
            Vertex(position: SIMD3<Float>( 1,  1, 0),
                   texCoord: SIMD2<Float>(1, 0),
                   color: color),  // Top-right
            
            Vertex(position: SIMD3<Float>(-1,  1, 0),
                   texCoord: SIMD2<Float>(0, 0),
                   color: color), // Top-left
        ]
        
        let indices: [UInt32] = [0, 1, 2, 2, 3, 0]
        
        let material = Material(textureNamed: "pink")
        
        guard let pipelineState = RenderPipelineStateLibrary.createDefault2D() else {
            fatalError("Couldn't create Default 2D pipeline state")
            return
        }
        
        let device = MetalContext.shared.device
        
        super.init(material: material,
                   vertexBuffer: device.makeBuffer(bytes: vertices, length: vertices.stride)!,
                   indexBuffer: device.makeBuffer(bytes: indices, length: indices.stride),
                   vertexCount: vertices.count,
                   indexCount: indices.count,
                   renderPipelineState: pipelineState)
        
    }
    
}
