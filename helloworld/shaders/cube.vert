#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aNormal;
layout (location = 2) in vec2 aTexCoords;
uniform mat4 modelTrans;
uniform mat4 viewTrans;
uniform mat4 projectionTrans;

out vec3 fragPos;
out vec2 TexCoords;
out vec3 normalVector;
void main()
{
   gl_Position = projectionTrans*viewTrans*modelTrans*vec4(aPos.xyz, 1.0);
   fragPos = vec3(viewTrans*modelTrans*vec4(aPos.xyz, 1.0));
   normalVector =mat3(transpose(inverse(viewTrans*modelTrans)))*aNormal;
   TexCoords = aTexCoords;
}