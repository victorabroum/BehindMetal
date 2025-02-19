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
    float2 uvNormal [[ attribute(3) ]];
} VertexIn;

typedef struct {
    float4 position [[ position ]];
    float4 color;
    float2 texCoords;
    float4 modelPosition;
    float2 uvNormal;
} RasterizeData;

typedef struct {
    float4x4 modelMatrix;
}ModelConstants;

typedef struct {
    float4x4 viewMatrix;
    float4x4 projectionMatrix;
}SceneConstants;

#endif /* Header_h */
