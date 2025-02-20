//
//  Texture.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//


import MetalKit

public class Texture {
    
    public static func loadTexture(named: String) -> MTLTexture! {
        
        let textureLoader = MTKTextureLoader(device: MetalContext.shared.device)
        
        do {
            return try textureLoader.newTexture(name: named, scaleFactor: 1, bundle: .main, options: [
                .SRGB: false
            ])
        } catch {
            print("Could not load texture named: \(named), error: \(error.localizedDescription)")
            return createEmptyTexture()
        }
    }
    
    public static func createEmptyTexture(size: CGSize = .init(width: 16, height: 16)) -> MTLTexture {
        // Definir o tamanho da textura
        let width = Int(size.width)
        let height = Int(size.height)

        // Criar o buffer de pixels com cor preta (ou qualquer cor que desejar)
        let pixelData = [UInt8](repeating: 0, count: width * height * 4) // Preto em RGBA

        let textureDescriptor = MTLTextureDescriptor()
        textureDescriptor.width = width
        textureDescriptor.height = height
        textureDescriptor.pixelFormat = .bgra8Unorm
        textureDescriptor.usage = [.shaderRead, .shaderWrite]

        let texture = MetalContext.shared.device.makeTexture(descriptor: textureDescriptor)!

        // Criar buffer de dados para enviar para a textura
        let region = MTLRegionMake2D(0, 0, width, height)
        texture.replace(region: region, mipmapLevel: 0, withBytes: pixelData, bytesPerRow: width * 4)

        return texture
    }
}
