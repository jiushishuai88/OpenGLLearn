#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aNormal;
layout (location = 2) in vec2 aTexCoords;


uniform mat4 modelTrans;
uniform mat4 viewTrans;
uniform mat4 projectionTrans;


out VS_OUT {
    vec2 texCoords;
    vec3 normal;
    vec3 position;
    vec3 fragPos;
} vs_out;


void main()
{
   gl_Position = projectionTrans*viewTrans*modelTrans*vec4(aPos.xyz, 1.0);
   vs_out.fragPos = vec3(viewTrans*modelTrans*vec4(aPos.xyz, 1.0));
   vs_out.normal =mat3(transpose(inverse(viewTrans*modelTrans)))*aNormal;
   vs_out.texCoords = aTexCoords;
   vs_out.position = vec3(modelTrans * vec4(aPos, 1.0));
}