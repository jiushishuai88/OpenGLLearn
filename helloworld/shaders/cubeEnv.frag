#version 330 core
out vec4 FragColor;

in vec3 Normal;
in vec3 Position;
in vec2 TexCoords;


uniform vec3 cameraPos;
uniform samplerCube skybox;
uniform sampler2D texture0;

void main()
{    
    vec3 I = normalize(Position - cameraPos);
    vec3 R = reflect(I, normalize(Normal));
    FragColor = mix(vec4(texture(skybox, R).rgb, 1.0),texture(texture0, TexCoords),0.5);
}