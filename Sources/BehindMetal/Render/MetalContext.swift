//
//  MetalContext.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//


import MetalKit

public class MetalContext {
    nonisolated(unsafe) public static let shared = MetalContext()
    
    public var device: MTLDevice
    public var commandQueue: MTLCommandQueue

    private init() {
        self.device = MTLCreateSystemDefaultDevice()!
        self.commandQueue = device.makeCommandQueue()!
    }
}
