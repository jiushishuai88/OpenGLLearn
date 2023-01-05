#pragma once
#include <glad/glad.h>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include "commomHeader.h"
#include <string>
#include <vector>

#define MAX_BONE_INFLENCE (4)
struct Vertex
{
	glm::vec3 Position;
	glm::vec3 Normal;
	glm::vec2 TexCoords;
	glm::vec3 Tangent;
	glm::vec3 Bitangent;
	int m_BoneIDs[MAX_BONE_INFLENCE];
	float m_Weights[MAX_BONE_INFLENCE];
};