
// TINY_FLOAT constant, to detect floating point values close to zero
#define TINY_FLOAT 0.00000001

#ifndef SCRIPT_API_v3507
managed struct Point
{
  int x;
  int y;
};
#endif

import Point *ParsePoint(String s);

//
// Extensions to Maths class
//
import int Abs(static Maths, int value);
import int Max(static Maths, int a, int b);
import int Min(static Maths, int a, int b);
import int Clamp(static Maths, int value, int min, int max);

import float AbsF(static Maths, float value);
import float MaxF(static Maths, float a, float b);
import float MinF(static Maths, float a, float b);
import float ClampF(static Maths, float value, float min, float max);

// Converts angle to the range of 0-359 degrees
import int Angle360(static Maths, int degrees);
// Converts angle to the range of [-Pi..+Pi]
//import float AnglePi(static Maths, float rads);
// Converts angle to the range of [-Pi..+Pi], the angle must be in the range [-3*Pi, 3*Pi]
import float AnglePiFast(static Maths, float rads);
// Converts angle to the range of [0..2Pi)
import float Angle2Pi(static Maths, float rads);
