# OpenGL image processing shaders
Simple vertex &amp; fragment OpenGL shaders for very basic image processing features (convolution &amp; point transform)

# Files
post_vertex.glsl   
post_fragment.glsl

# Usage
These shaders should be used for postprocessing  
Vertex shader contains all the necessary data to draw triangle spanning the screen so you just need to have an empty vao and draw with *glDrawArrays(GL_TRIANGLES, 0, 3);*

# Example kernels
You can use whatever kernel you need && change its dimensions depending on your needs.
   
*Gauss 5x5 kernel (multiplier 1.0/256.0):*     
{{ 1,  4,  6,  4, 1 },   
 { 4, 16, 24, 16, 4 },   
 { 6, 24, 36, 24, 6 },    
 { 4, 16, 24, 16, 4 },   
 { 1,  4,  6,  4, 1 }}

*Mean filter 3x3 (multiplier 1.0/9.0):*   
{{ 1, 1, 1},   
 { 1, 1, 1},   
 { 1, 1, 1}}   
 
 *Laplace edge detection 3x3 kernel (multiplier 1.0):*   
 {{ 0, -1,  0},   
 { -1,  4, -1},   
 {  0, -1,  0}}   

