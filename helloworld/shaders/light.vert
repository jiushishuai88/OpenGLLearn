#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec2 aTexCoord;
out vec4 vertexColor;
out vec2 TexCoord;
uniform mat4 modelTrans;
uniform mat4 viewTrans;
uniform mat4 projectionTrans;
void main()
{
   gl_Position = projectionTrans*viewTrans*modelTrans*vec4(aPos.xyz, 1.0);
   //TexCoord = aTexCoord;
}