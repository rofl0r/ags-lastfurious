
// Two dimensional vector composed of floating point coordinates
managed struct VectorF
{
  float x;
  float y;
  
  import float    angle();
  import float    length();
  import float    lengthSquared();
  
  import bool     isZero();
  import static bool isNull(VectorF *v);
  
  import void     add(VectorF *v);
  import void     add2(float x, float y);
  import void     addScaled(VectorF *v, float scale);
  import void     clampXY(VectorF *min, VectorF *max);
  import void     makeZero();
  import void     max(VectorF *other);
  import void     min(VectorF *other);
  import void     negate();
  import void     normalize();
  import void     rotate(float rads);
  import void     scale(float scale);
  import void     set(VectorF *v);
  import void     set2(float x, float y);
  import void     truncate(float max_length);
 
  
  import VectorF *clone();
  // Returns a directional angle between two vectors (required to rotate from a to b)
  import static float    angleBetween(VectorF *a, VectorF *b);
  import static VectorF *create(int x, int y);
  import static VectorF *createF(float x, float y);
  // Distance between points
  import static float    distance(VectorF *a, VectorF *b);
  // Dot product of two vectors
  import static float    dotProduct(VectorF *a, VectorF *b);
  // Projection of vector a on vector b
  import static float    projection(VectorF *a, VectorF *b);
  import static VectorF *subtract(VectorF *a, VectorF *b);
  import static VectorF *zero();
};