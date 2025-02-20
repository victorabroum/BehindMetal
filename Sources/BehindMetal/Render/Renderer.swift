//
//  Renderer.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//


import MetalKit

public class Renderer: NSObject, MTKViewDelegate {
    
    private let commandQueue: MTLCommandQueue

    public var sceneRenderDelegate: SceneRendererDelegate?
    
    override public init() {
        self.commandQueue = MetalContext.shared.device.makeCommandQueue()!
    }
    
    public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    public func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
              let renderPassDescriptor = view.currentRenderPassDescriptor,
              let commandBuffer = commandQueue.makeCommandBuffer(),
              let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        else { return }

        commandEncoder.setDepthStencilState(DepthStencilStateLibrary.main.basic)
        
        sceneRenderDelegate?.render(commandEncoder: commandEncoder, atTime: 1 / Float(view.preferredFramesPerSecond))
        
        commandEncoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
