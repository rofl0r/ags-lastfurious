
#define MAX_WALKABLE_AREAS 16

struct Track
{
  /// Get/set track's gravity (default is 9.807)
  import static attribute float Gravity;
  /// Get/set track's air resistance factor. Air resistance force is applied to any object moving on the
  /// track, and is proportional to its squared velocity.
  import static attribute float AirResistance;
  
  /// Get/set if this area is an obstacle and cannot be moved onto.
  import static attribute bool IsObstacle[];
  /// Get/set terrain's slide friction factor for the particular walkable area.
  /// Slide friction is a force that is applied to an object sliding (but not rolling) upon the surface.
  import static attribute float TerraSlideFriction[];
  /// Get/set terrain's rolling friction factor for the particular walkable area.
  /// Rolling friction is a force that is applied to an object rolling upon the surface.
  /// Usually, the harder and flatter the surface is, the LOWER the rolling friction is. Softer
  /// terrain (sand, muddy soil) produce higher rolling friction.
  import static attribute float TerraRollFriction[];
  /// Get/set terrain grip factor for the walkable area.
  /// Grip is a value between 0.0 and 1.0 which determines how well the engine's power translates through
  /// the wheels into surface, and pushing the car. 
  /// TODO: in theory the grip should somehow be connected with friction, but I'd leave it separated
  /// for now, for the sake of simplicity (we lack proper formulas to make it work well).
  import static attribute float TerraGrip[];
  /// Get/set additional enviroment resistance factor.
  /// This is an abstract force applied to an object moving in the unusual area: water streams, sand dunes,
  /// shrubbery, and so forth.
  import static attribute float EnvResistance[];
};
