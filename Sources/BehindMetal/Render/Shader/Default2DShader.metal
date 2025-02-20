//
//  File.metal
//  BehindMetal
//
//  Created by Victor Vasconcelos on 19/02/25.
//

#include <metal_stdlib>
#include "CommonTypes.h"
using namespace metal;

vertex RasterizeData vertex_default2D(const VertexIn vIn [[ stage_in ]],
                                 constant SceneConstants &sceneConstant [[buffer(1)]],
                                 constant ModelConstants &modelConstant [[buffer(2)]]) {
    RasterizeData rd;
    rd.position = sceneConstant.projectionMatrix * sceneConstant.viewMatrix * modelConstant.modelMatrix * float4(vIn.position, 1);
    rd.modelPosition = modelConstant.modelMatrix * float4(vIn.position, 1);
    rd.texCoords = vIn.texCoords;
    rd.uvNormal = normalize(vIn.uvNormal);
    return rd;
}

fragment float4 fragment_default2D(RasterizeData rd [[ stage_in ]],
                                     texture2d<float> texture [[texture(0)]],
                                   constant SceneConstants &sceneConstant [[buffer(1)]]) {
    
    constexpr sampler textureSampler(filter::nearest, address::repeat);
    
    float4 textureColor = texture.sample(textureSampler, rd.texCoords);
    
    if (textureColor.a < 0.01) { discard_fragment(); }
    
    // Calculate Diffuse Light
    float time = sceneConstant.timeElapsed;
    float3 lightPosition = float3(sin((-time * 0.5)) * 10, 0, 0);
//    float3 lightPosition = float3(1, 1, 1);
    float3 lightDir = normalize(lightPosition - rd.modelPosition.xyz);
    float3 lightColor = float3(1, 1, 1);
    
    float3 diffuseIntensity = max(dot(rd.uvNormal, lightDir), float3(0));
    
//    float4 colorTint = float4(sin(time * 0.1) + 1, 1, 0, 1) * textureColor;
    float4 colorTint = float4(1, 0.4, 1, 1) * textureColor;
    
//    return colorTint;

//    float3 finalColor = textureColor.rgb * (lightColor * diffuseIntensity + 0.3);
    float3 finalColor = colorTint.rgb * (lightColor * diffuseIntensity + 0.3);
    
    
    return float4(finalColor, textureColor.a);

    return textureColor;
}
