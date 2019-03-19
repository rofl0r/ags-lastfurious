
#define NUM_COLLISION_POINTS 4

struct VehicleBase
{
  /// Tells if vehicle is initialized
  import readonly attribute bool IsInit;
  
  /// Initialize vehicle by binding it to the given character and graphical representation
  import void SetCharacter(Character *c, int carSprite, CharacterDirection carSpriteDir, int view = 0, int loop = 0, int frame = 0);
  /// Reset vehicle, place at given position, zero all forces, etc
  import void Reset(VectorF *pos, VectorF *dir);
  /// Run vehicle physics
  import void Run(float deltaTime);
  /// Uninitialize vehicle by removing character's reference and all allocated resources
  import void UnInit();
  
  protected import void DetachCharacter();
  protected import void ResetBase(VectorF *pos, VectorF *dir);
  protected import void RunPhysicsBase(float deltaTime);
  protected import void UnInitBase();
  
  /// Synchronizes character with the vehicle position and direction
  protected import void SyncCharacter();
  /// Update vehicle body parameters with the new position and direction
  protected import void UpdateBody();
  
  
  /*protected*/ Character *c; // character that represents this vehicle
  
  protected int carSprite; // default car sprite, at angle carAngle
  protected int carSpriteAngle; // angle at which default car sprite is given
  protected ViewFrame *viewFrame; // view frame to update
  protected DynamicSprite *dSprite; // dynamic sprite to use
  protected int dSpriteRotation; // last angle used to rotate the dynamic sprite
  
  protected VectorF *collPointOff[NUM_COLLISION_POINTS]; // (relative) points at which to check the collision and interaction with enviroment
  
  /*protected*/ float    bodyLength;
  /*protected*/ float    bodyWidth;
  /*protected*/ VectorF *position; // vehicle position
  /*protected*/ VectorF *direction; // vehicle face direction
  /*protected*/ VectorF *velocity; // final linear velocity, summing up all the forces
  /*protected*/ float    angularVelocity; // final angular velocity (positive value rotates vehicle clockwise)
  
  /*protected*/ VectorF *collPoint[NUM_COLLISION_POINTS]; // (absolute) points at which to check the collision and interaction with enviroment
};
