//
//  MetalContext.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//


import MetalKit

public class MetalContext {
    nonisolated(unsafe) public static let shared = MetalContext()
    
    private(set) var device: MTLDevice
    private(set) var commandQueue: MTLCommandQueue

    private init() {
        self.device = MTLCreateSystemDefaultDevice()!
        self.commandQueue = device.makeCommandQueue()!
    }
}
