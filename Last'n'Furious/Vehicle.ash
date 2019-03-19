
struct Vehicle extends VehicleBase
{
  /// Get/set engine acceleration (0.0 - 1.0)
  import attribute float Accelerator;
  /// Get current engine's power
  import readonly attribute float EnginePower;
  /// Get/set brake force
  import attribute float Brakes;
  
  //
  // Car body properties
  //
  // The mass of the car
  /*protected*/ float bodyMass;
  // Abstract aerodynamic factor (less is better)
  /*protected*/ float bodyAerodynamics;
  // How much of car's energy is lost during impact (0.0 - 1.0)
  /*protected*/ float hardImpactLossFactor;
  /*protected*/ float softImpactLossFactor;
  
  //
  // Engine
  //
  // We do not have transmission in this simulation, engine is directly connected to the
  // driving wheels, does not have "workload" concept, and cannot stall.
  //
  // * Engine has "max power" constant, and "current power" dynamic value.
  // * When acceleration is enabled (power goal set), current power becomes equal to the
  //   fraction of the max power, defined by "accelerator" value (or "power goal" value).
  // * Current power directly translates into drive wheel's torque.
  // * Power can be negative, in which case the drive wheel is supposed to rotate backwards.
  //
  
  // The maximal amount of power that engine can produce.
  // Can be positive or negative, depending on the engine mode.
  /*protected*/ float engineMaxPower;
  // Percentage of power use (0.0 - 1.0)
  /*protected*/ float engineAccelerator;
  // The engine's power goal. This is the value current power is trying to achieve.
  /*protected*/ float enginePowerGoal;
  // Current engine's power.
  /*protected*/ float enginePower;
  
  //
  // Brakes
  //
  // Brakes work simple: they instantly reduce driving wheel's torque by certain fraction.
  //
  
  // The power applied against the driving wheel's "torque". In fraction of torque loss (0.0 - 1.0).
  /*protected*/ float brakePower;
  
  //
  // Driving wheels.
  //
  // Simulation of driving wheels goes as this: torque is calculated from engine's power as 1:1,
  // and creates the driving force that pushes the car.
  // This force may be adjusted by the "grip" factor, which determines how much of the torque
  // converts into driving force. Therefore with the best grip driving force equals torque.
  //
  
  // The "torque" is a measure of how powerfull the wheel rotation is.
  /*protected*/ float driveWheelTorque;
  // The abstract "grip" of the drive wheel, works as a factor in relation between wheel's torque and drive force.
  // Proper values are 0.0 to 1.0. This is a dynamic property that changes depending on a surface the car is on.
  /*protected*/ float driveWheelGrip;
  // Driving force is trying to move the car. Depends on the torque and wheel's grip.
  // This force is one-dimensional (therefore represented by float), when applied to 2D space its vector always
  // matches one of a car's body.
  /*protected*/ float driveWheelForce;
  
  //
  // Steering wheel (we assume there's only one "global one", separate from driving wheel, for simplicity)
  // 
  
  // Distance between driving and steering axle
  /*protected*/ float distanceBetweenAxles;
  /*protected*/ float stillTurningVelocity;
  // The angle between steering wheel's direction and car's direction (or rather drive wheel's direction, for that's matters)
  /*protected*/ float steeringWheelAngle;
  /*protected*/ VectorF *turningAccel;
  /*protected*/ float driftVelocityFactor;
  
  //
  // Enviroment
  //
  // Vehicle's weight force (depends on mass, gravity and elevation of surface)
  /*protected*/ float weightForce;
  // Average surface grip
  /*protected*/ float envGrip;
  // Average surface's slide friction
  /*protected*/ float envSlideFriction;
  // Average surface's roll friction
  /*protected*/ float envRollFriction;
  // Average custom enviroment resistance
  /*protected*/ float envResistance;
  
  bool strictCollisions;
  // Parameters telling if particular point is colliding with an obstacle (stores area ID)
  /*protected*/ int collPtHit[NUM_COLLISION_POINTS];
  /*protected*/ int collPtCarHit[NUM_COLLISION_POINTS];
  /*protected*/ int numHits;
  /*protected*/ int numCarHits;
  // Previous positions of the collision points
  /*protected*/ VectorF *oldCollPt[NUM_COLLISION_POINTS];
  // Previous hit flags
  /*protected*/ int oldCollPtHit[NUM_COLLISION_POINTS];
  /*protected*/ int oldCollPtCarHit[NUM_COLLISION_POINTS];
  
  //
  // Information for external scripts
  //
  // Enviroment resistance forces for rolling and sliding directions.
  float infoRollAntiforce;
  float infoSlideAntiforce;
  VectorF *infoImpact;
  
  
  /// Run vehicle physics
  import protected void RunPhysics(float deltaTime);
  /// Update enviroment parameters (terrain friction, etc)
  import protected void UpdateEnviroment();
  /// Run vehicle's collisions
  import protected void RunCollision(VectorF *impactVelocity, float deltaTime);
  
  import VectorF *DetectCollision(VectorF *rect[], VectorF *otherVelocity, int otherIndex);
};


//
// Override base class methods using AGS extender functions
//
/// Reset vehicle, place at given position, zero all forces, etc
import void Reset(this Vehicle*, VectorF *pos, VectorF *dir);
/// Run vehicle physics
import void Run(this Vehicle*, float deltaTime);
/// Uninitialize vehicle by removing character's reference and all allocated resources
import void UnInit(this Vehicle*);