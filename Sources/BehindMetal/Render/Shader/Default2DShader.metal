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
                                 constant SceneConstants &sceneContant [[buffer(1)]],
                                 constant ModelConstants &modelConstant [[buffer(2)]]) {
    RasterizeData rd;
    rd.position = sceneContant.projectionMatrix * sceneContant.viewMatrix * modelConstant.modelMatrix * float4(vIn.position, 1);
    rd.modelPosition = modelConstant.modelMatrix * float4(vIn.position, 1);
    rd.texCoords = vIn.texCoords;
    return rd;
}

fragment float4 fragment_default2D(RasterizeData rd [[ stage_in ]],
                                     texture2d<float> texture [[texture(0)]]) {
    
    constexpr sampler textureSampler(filter::nearest, address::repeat);
    
    float4 textureColor = texture.sample(textureSampler, rd.texCoords);
    
    if (textureColor.a < 0.01) { discard_fragment(); }
    
    return textureColor;
}
