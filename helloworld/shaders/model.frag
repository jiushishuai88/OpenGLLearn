#version 330 core
struct PointLight {
    vec3 lightPos;
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;

    float constant;
    float linear;
    float quadratic;
};
struct DirectionalLight {
    vec3 direction;
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

struct SpotLight {
    vec3  position;
    vec3  direction;
    float cutOff;
    float outerCutOff;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;

    float constant;
    float linear;
    float quadratic;
};
out vec4 FragColor;
in vec3 normalVector;
in vec3 fragPos;
uniform PointLight pointLight;
uniform DirectionalLight dirLight;
uniform SpotLight spotLight;
uniform mat4 viewTrans;
in vec2 TexCoords;

uniform sampler2D texture_diffuse1;
uniform sampler2D texture_specular1;
uniform sampler2D texture_normal1;
uniform sampler2D texture_height1;

void main()
{    
       vec3 viewDir = normalize(- fragPos);
    vec3 norm = normalize(normalVector);
     //点光源
    vec3 pointLightPos = vec3(viewTrans * vec4(pointLight.lightPos, 1.0));
    vec3 pointLightDir = normalize(pointLightPos-fragPos);
    float pointLightDistance = length(pointLightPos - fragPos);
    float pointAttenuation = 1.0 / (pointLight.constant + pointLight.linear * pointLightDistance + 
                pointLight.quadratic * (pointLightDistance * pointLightDistance));
    float pointDiff = max(dot(norm, pointLightDir), 0.0);
    vec3 pointDiffuse = pointDiff*pointLight.diffuse* texture(texture_diffuse1,TexCoords).rgb;
    vec3 pointAmbient = texture(texture_diffuse1,TexCoords).rgb * pointLight.ambient;
    vec3 pointReflectDir = reflect(-pointLightDir, norm);
    float pointSpec = pow(max(dot(viewDir, pointReflectDir), 0.0), 0.4*128);
    vec3 pointSpecular =texture(texture_specular1,TexCoords).rgb * pointSpec * pointLight.specular;
    vec3 pointResult = (pointAmbient+pointDiffuse+pointSpecular)*pointAttenuation;
    //方向光
    vec3 dirLightDir = normalize(-dirLight.direction);
    float dirDiff = max(dot(norm, dirLightDir), 0.0);
    vec3 dirDiffuse = dirDiff*dirLight.diffuse* texture(texture_diffuse1,TexCoords).rgb;
    vec3 dirAmbient = texture(texture_diffuse1,TexCoords).rgb * dirLight.ambient;
    vec3 dirReflectDir = reflect(-dirLightDir, norm);
    float dirSpec = pow(max(dot(viewDir, dirReflectDir), 0.0), 0.4*128);
    vec3 dirSpecular =texture(texture_specular1,TexCoords).rgb * dirSpec * dirLight.specular;
    vec3 dirResult = (dirAmbient+dirDiffuse+dirSpecular);

     //聚光灯
     vec3 spotResult;
     vec3 spotLightPos =  vec3(viewTrans * vec4(spotLight.position, 1.0));
     vec3 spotLightDir = normalize(spotLightPos-fragPos);
     float spotTheta = dot(spotLightDir,-spotLight.direction);
     if(spotTheta>spotLight.outerCutOff)
     {
        vec3 SpotAmbient = spotLight.ambient * texture(texture_diffuse1, TexCoords).rgb;
        
        float spotDiff = max(dot(norm, spotLightDir), 0.0);
        vec3 spotDiffuse = spotLight.diffuse * spotDiff * texture(texture_diffuse1, TexCoords).rgb;  

        vec3 spotReflectDir = reflect(-spotLightDir, norm);  
        float spotSpec = pow(max(dot(viewDir, spotReflectDir), 0.0), 0.4*128);
        vec3 spotSpecular = spotLight.specular * spotSpec * texture(texture_specular1, TexCoords).rgb;  
        
        float spotDistance    = length(spotLight.position - fragPos);
        float spotAttenuation = 1.0 / (spotLight.constant + spotLight.linear * spotDistance + spotLight.quadratic * (spotDistance * spotDistance));
        float spotEpsilon   = spotLight.cutOff - spotLight.outerCutOff;
        float spotIntensity = clamp((spotTheta - spotLight.outerCutOff)/spotEpsilon, 0.0, 1.0); 
            
        spotResult = (SpotAmbient+ spotDiffuse + spotSpecular)*spotAttenuation*spotIntensity;
     }
    FragColor = vec4(pointResult+dirResult+spotResult, 1.0);
}