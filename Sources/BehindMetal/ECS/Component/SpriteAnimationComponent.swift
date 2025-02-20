//
//  AnimationComponent.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//


import BehindECS

public class SpriteAnimationComponent: BComponent {
    public var frameCount: Int  // Quantidade de frames na sprite sheet
    public var frameTime: Float // Tempo por frame (em segundos)
    public var currentFrame: Int = 0 // Índice do frame atual
    public var elapsedTime: Float = 0 // Acumulador de tempo para troca de frame
    
    public init(frameCount: Int, frameTime: Float, currentFrame: Int = 0) {
        self.frameCount = frameCount
        self.frameTime = frameTime
        self.currentFrame = currentFrame
        self.elapsedTime = 0
    }
}
