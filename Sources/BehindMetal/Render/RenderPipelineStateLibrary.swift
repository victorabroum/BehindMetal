//
//  RenderPipelineDescriptorLibrary.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//

import MetalKit

public enum RenderPipelineType {
    case simple, default2D
}

public class RenderPipelineStateLibrary {
    var libraries: [RenderPipelineType: MTLRenderPipelineState] = [:]
    
    public static func createDefault2D() -> MTLRenderPipelineState? {
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        let device = MetalContext.shared.device
        
        guard let libraryURL = Bundle.module.url(forResource: "default", withExtension: "metallib"),
              let library = try? device.makeLibrary(URL: libraryURL) else {
            print("Couldn't create a Default Library")
            return nil
        }
        
        pipelineDescriptor.vertexFunction = library.makeFunction(name: "vertex_default2D")
        pipelineDescriptor.fragmentFunction = library.makeFunction(name: "fragment_default2D")
        
        
        let blendDescriptor = MTLRenderPipelineColorAttachmentDescriptor()
        blendDescriptor.isBlendingEnabled = true
        blendDescriptor.rgbBlendOperation = .add
        blendDescriptor.alphaBlendOperation = .add
        blendDescriptor.sourceRGBBlendFactor = .sourceAlpha
        blendDescriptor.destinationRGBBlendFactor = .oneMinusSourceAlpha

        blendDescriptor.pixelFormat = .bgra8Unorm

        pipelineDescriptor.colorAttachments[0] = blendDescriptor
        
        pipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
        
        // Setup VertexDescriptor
        let vertexDescriptor = MTLVertexDescriptor()
        
        // Position
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = 0
        vertexDescriptor.attributes[0].bufferIndex = 0
        
        // TexCoord
        vertexDescriptor.attributes[1].format = .float2
        vertexDescriptor.attributes[1].offset = SIMD3<Float>.size
        vertexDescriptor.attributes[1].bufferIndex = 0
        
        // Color
        vertexDescriptor.attributes[2].format = .float4
        vertexDescriptor.attributes[2].offset = SIMD3<Float>.size + SIMD2<Float>.size
        vertexDescriptor.attributes[2].bufferIndex = 0
        
        // uv Normal
        vertexDescriptor.attributes[3].format = .float3
        vertexDescriptor.attributes[3].offset = SIMD3<Float>.size + SIMD2<Float>.size + SIMD4<Float>.size
        vertexDescriptor.attributes[3].bufferIndex = 0
        
        vertexDescriptor.layouts[0].stride = Vertex.stride
        
        pipelineDescriptor.vertexDescriptor = vertexDescriptor
        
        do {
            return try MetalContext.shared.device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            fatalError("Error creating pipeline state: \(error.localizedDescription)")
        }
    }
}
