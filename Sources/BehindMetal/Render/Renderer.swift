//
//  Renderer.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//


import MetalKit

class Renderer: NSObject, MTKViewDelegate {
    
    private let commandQueue: MTLCommandQueue

    public var sceneRenderDelegate: SceneRendererDelegate?
    
    override init() {
        self.commandQueue = MetalContext.shared.device.makeCommandQueue()!
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
              let renderPassDescriptor = view.currentRenderPassDescriptor,
              let commandBuffer = commandQueue.makeCommandBuffer(),
              let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        else { return }

        sceneRenderDelegate?.render(commandEncoder: commandEncoder, atTime: 1 / Float(view.preferredFramesPerSecond))
        
        commandEncoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
