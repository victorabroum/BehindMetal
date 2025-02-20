//
//  Header.h
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//

using namespace metal;

#ifndef CommonTypes_h
#define CommonTypes_h

typedef struct {
    float3 position [[ attribute(0) ]];
    float2 texCoords [[ attribute(1) ]];
    float4 color [[ attribute(2) ]];
    float3 uvNormal [[ attribute(3) ]];
} VertexIn;

typedef struct {
    float4 position [[ position ]];
    float4 color;
    float2 texCoords;
    float4 modelPosition;
    float3 uvNormal;
} RasterizeData;

typedef struct {
    float4x4 modelMatrix;
} ModelConstants;

typedef struct {
    float4x4 viewMatrix;
    float4x4 projectionMatrix;
    float timeElapsed;
} SceneConstants;

enum LightType {
    Directional = 0,
    Point = 1,
    Area = 2
};

typedef struct {
    LightType type;        // Tipo de luz (direcional, pontual, área)
    float3 color;          // Cor da luz
    float intensity;       // Intensidade da luz
    float3 position;       // Posição da luz (para luz pontual e de área)
    float attenuation;     // Atenuação (para luz pontual)
    float size;            // Tamanho da área iluminada (para luz de área)
} Light;

#endif /* Header_h */
