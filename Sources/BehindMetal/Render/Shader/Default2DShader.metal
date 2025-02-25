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
    rd.uvNormal = normalize(float3(0, 0, 1));
    return rd;
}

fragment float4 fragment_default2D(RasterizeData rd [[ stage_in ]],
                                   texture2d<float> texture [[texture(0)]],
                                constant LightData &lightData [[buffer(1)]]) {
    
    constexpr sampler textureSampler(filter::nearest, address::repeat);
    
    float4 textureColor = texture.sample(textureSampler, rd.texCoords);
    
    if (textureColor.a < 0.01) { discard_fragment(); }
    
    // Calculate Lighting
    
    float3 finalColor = textureColor.rgb;
    float3 normal = rd.uvNormal;
    
    for(int i = 0; i < 8; i++) {
        Light light = lightData.lights[i];
        
        if (light.isActive == 0) { continue; }
        
        if(light.type == Directional) {
            float3 direction = normalize(light.position); // Direção da luz
            float diffuse = max(dot(normal, direction), 0.0);
            
//            return float4((diffuse * 0.5) + 0.5, 0, 0, 1);
//            return float4((direction * diffuse * 0.5) + 0.5, 1.0);
            
            finalColor += light.color * light.intensity * diffuse;
        }else if (light.type == Point) {

            float3 lightDir = light.position - rd.modelPosition.xyz;

            float distance = length(lightDir);
            lightDir = normalize(lightDir);

            float attenuation = 1.0 / (1.0 + light.attenuation * distance * distance);
            
//            float diffuse = max(dot(normal, lightDir), 0.0) * attenuation * light.size;
            float diffuse = max(dot(normal, 1 - lightDir), 0.0) * attenuation;
            
            finalColor += light.color * light.intensity * diffuse;
            
//            return float4((lightDir * 0.5) + 0.5, 1.0);
        }
    }
    return float4(finalColor.rgb, textureColor.a);
}
