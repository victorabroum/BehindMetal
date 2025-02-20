//
//  DepthStencilLibrary.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 20/02/25.
//

import MetalKit

public class DepthStencilStateLibrary {
    
    nonisolated(unsafe) public static let main = DepthStencilStateLibrary()
    
    public var basic: MTLDepthStencilState?
    
    private init() {
        basic = DepthStencilStateLibrary.basicDepthStencilState()
    }
    
    static func basicDepthStencilState() -> MTLDepthStencilState? {
        let descriptor = MTLDepthStencilDescriptor()
        
        descriptor.depthCompareFunction = .less
        descriptor.isDepthWriteEnabled = true
        
        return MetalContext.shared.device.makeDepthStencilState(descriptor: descriptor)
    }
}
