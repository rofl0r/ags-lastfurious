
struct VehicleSimple
{
  protected Character *c; // character that represents this vehicle
  protected int carSprite; // default car sprite, at angle carAngle
  protected int carSpriteAngle; // angle at which default car sprite is given
  protected ViewFrame *viewFrame; // view frame to update
  protected DynamicSprite *sprite; // sprite to use
  protected int currentSpriteRotation; // last angle used to rotate the sprite
  
  protected VectorF *collPointOff[NUM_COLLISION_POINTS]; // (relative) points at which to check the collision and interaction with enviroment
  protected VectorF *collPoint[NUM_COLLISION_POINTS]; // (absolute) points at which to check the collision and interaction with enviroment
  
  protected float engine; // engine power (may be negative), accelerates driveForce
  protected float steering; // wheel steering (negative = left, positive = right)
  protected float brakes; // wheel brakes force (only positive), decelerate driveForce
  protected float friction; // terrain friction (only positive)
  // NOT IMPLEMENTED YET
  //protected float resistance; // total resistance, updated from terrain friction + brakes (only positive)
  //protected float drag; // drag, or air friction, increases with actual velocity (only positive)
  
  protected VectorF *position; // vehicle position
  /*protected*/ VectorF *direction; // vehicle face direction, updated by steering
  float directionAngle; // vehicle face direction angle, updated by steering (cached for faster calculations)
  /*protected*/ VectorF *thrust; // the force of the rotating wheels pushing vehicle forward, aligned with car's direction
  protected VectorF *brakeForce; // brakes vector, applied after thrust
  // TODO: current implementation does not distinguish brakeForce vs thrust and other forces.
  // This will work more or less until other forces (like impact) are introduced
  // TODO: because of that, currently velocity is also aligned with thrust.
  // This is not correct, but will work for the time being
  protected float driveVelocityValue;
  /*protected*/ VectorF *driveVelocity; // velocity composed of only drive forces, always aligned with car's direction
  protected VectorF *impactVelocity; // velocity composed of impact impulses
  VectorF *velocity; // final velocity, summing up all the forces
  //protected VectorF *velocityDirection; // normalized final velocity vector
  // For reading info only --
  float thrustForceValue;
  float brakeForceValue;
  
  // Brakes power
  import attribute float Brakes;
  // Engine power (forward/backward thrust)
  import attribute float Engine;
  // Vehicle steering (wheel turn), in radians
  import attribute float Steering;
  // Current surface friction
  import readonly attribute float Friction;
  
   // temp, for reading info only
  float terrafriction[NUM_COLLISION_POINTS];
  Point *colpt[NUM_COLLISION_POINTS];
  
  // initialize vehicle by binding it to the given character and graphical representation
  import void setCharacter(Character *c, int carSprite, CharacterDirection carSpriteDir, int view = 0, int loop = 0, int frame = 0);
  // reset vehicle, zero all forces and place at given position
  import void reset(VectorF *pos, VectorF *dir);
  
  // run simple vehicle physics:
  // * drive velocity is instantly aligned with car direction on every update;
  // * thrust and break forces are "one-dimensional": applied always along the drive velocity vector;
  // * thrust is a constant proportional to engine power, and is gained instantly;
  // * friction is a linear multiplier to drive velocity (max velocity = engine power * friction);
  // * braking force are applied directly to drive velocity;
  // * steering is loosely bound to the drive velocity's value, allow to turn standing car;
  // * very simple impact mechanics: impacts contribute to drive velocity, and produce temporary impulse negated by its own braking power.
  import void run(float deltaTime);
  // process interaction with enviroment (collisions, surface friction)
  protected import void processInteraction(float deltaTime);
  
  // synchronize character with the vehicle position
  protected import void syncCharacter();
};
