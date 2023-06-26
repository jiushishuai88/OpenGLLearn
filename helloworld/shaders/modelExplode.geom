#version 330 core
layout (triangles) in;
layout (triangle_strip, max_vertices = 3) out;

in VS_OUT {
    vec2 texCoords;
    vec3 normal;
    vec3 position;
    vec3 fragPos;
} gs_in[];

out GS_OUT
{
    vec2 texCoords;
    vec3 normal;
    vec3 position;
    vec3 fragPos;
}gs_out;

uniform float time;

vec4 explode(vec4 position, vec3 normal)
{
    float magnitude = 2.0;
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
    gl_Position = explode(gl_in[0].gl_Position,  gs_in[0].normal);
    gs_out.texCoords = gs_in[0].texCoords;
    gs_out.normal = gs_in[0].normal;
    gs_out.position = gs_in[0].position;
    gs_out.fragPos = gs_in[0].fragPos;
    EmitVertex();
    gl_Position = explode(gl_in[1].gl_Position,  gs_in[0].normal);
    gs_out.texCoords = gs_in[1].texCoords;
    gs_out.normal = gs_in[1].normal;
    gs_out.position = gs_in[1].position;
    gs_out.fragPos = gs_in[1].fragPos;
    EmitVertex();
    gl_Position = explode(gl_in[2].gl_Position,  gs_in[0].normal);
    gs_out.texCoords = gs_in[2].texCoords;
    gs_out.normal = gs_in[2].normal;
    gs_out.position = gs_in[2].position;
    gs_out.fragPos = gs_in[2].fragPos;
    EmitVertex();
    EndPrimitive();
}