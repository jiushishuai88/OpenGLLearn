#version 330 core
layout (triangles) in;
layout (triangle_strip, max_vertices = 3) out;

in VS_OUT {
    vec2 texCoords;
    vec3 normal;
    vec3 position;
} gs_in[];

out vec2 TexCoords;
out vec3 Normal;
out vec3 Position;

uniform float time;

vec4 explode(vec4 position, vec3 normal)
{
    float magnitude = 10.0;
    vec3 direction = normal * ((sin(time) + 1.0) / 2.0) * magnitude; 
    return position + vec4(direction, 0.0);
}

vec3 GetNormal()
{
    vec3 a = vec3(gl_in[0].gl_Position) - vec3(gl_in[1].gl_Position);
    vec3 b = vec3(gl_in[2].gl_Position) - vec3(gl_in[1].gl_Position);
    return normalize(cross(a, b));
}

void main() {    
    vec3 normal = GetNormal();
    gl_Position = explode(gl_in[0].gl_Position,  gs_in[0].normal);
    TexCoords = gs_in[0].texCoords;
    Normal = gs_in[0].normal;
    Position = gs_in[0].position;
    EmitVertex();
    gl_Position = explode(gl_in[1].gl_Position,  gs_in[0].normal);
    TexCoords = gs_in[1].texCoords;
    Normal = gs_in[1].normal;
    Position = gs_in[1].position;
    EmitVertex();
    gl_Position = explode(gl_in[2].gl_Position,  gs_in[0].normal);
    TexCoords = gs_in[2].texCoords;
    Normal = gs_in[2].normal;
    Position = gs_in[2].position;
    EmitVertex();
    EndPrimitive();
}