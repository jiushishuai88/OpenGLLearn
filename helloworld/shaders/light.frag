#version 330 core
out vec4 FragColor;
in vec2 TexCoord;
uniform vec3 lightColor;
uniform vec3 objectColor;

void main()
{
	//FragColor = texture(ourTexture0, TexCoord)* texture(ourTexture1, TexCoord).a;
	 FragColor = vec4(1.0);
}