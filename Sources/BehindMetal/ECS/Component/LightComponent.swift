//
//  LightComponent.swift
//  BehindMetal
//
//  Created by Victor Vasconcelos on 20/02/25.
//

import BehindECS
import simd

public enum LightType: Int32, Sizeable {
    case directional = 0
    case point = 1
    case area = 2
    case empty = 3
}

public class LightComponent: BComponent, Sizeable {
    var id: Int32
    var type: LightType
    var color: SIMD3<Float>
    var intensity: Float
    var position: SIMD3<Float>
    var attenuation: Float
    var size: Float
    var isActive: Int32
    
    var sceneController: SceneController?
    
    public init() {
        self.id = LightComponent.generateID()
        self.type = .empty
        self.color = .init(0, 0, 0)
        self.intensity = 0
        self.position = .init(0, 0, 0)
        self.attenuation = 0
        self.size = 0
        self.sceneController = nil
        self.isActive = 0
    }
    
    public init(type: LightType,
                color: SIMD3<Float>,
                intensity: Float,
                position: SIMD3<Float>,
                attenuation: Float,
                size: Float,
                isActive: Bool = true,
                sceneController: SceneController) {
        self.id = LightComponent.generateID()
        self.type = type
        self.color = color
        self.intensity = intensity
        self.position = position
        self.attenuation = attenuation
        self.size = size
        self.sceneController = sceneController
        self.isActive = isActive ? 1 : 0
    }
    
    nonisolated(unsafe) private static var nextID: Int32 = 0
    
    public static func generateID() -> Int32 {
        let resultID = nextID
        nextID += 1
        return resultID
    }
}

extension LightComponent: Equatable {
    public static func == (lhs: LightComponent, rhs: LightComponent) -> Bool {
        return lhs.type == rhs.type && lhs.color == rhs.color && lhs.position == rhs.position
    }
}
