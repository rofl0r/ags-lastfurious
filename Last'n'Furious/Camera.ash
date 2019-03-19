///////////////////////////////////////////////////////////////////////////////
//
// Camera module.
//
// Module handles the camera control.
//
///////////////////////////////////////////////////////////////////////////////

/// Camera static struct manages game camera, which may be targetted
/// at certain game object, or set to any arbitrary coordinates.
struct Camera
{
  //
  // Behavior setup
  //
  /// Linear acceleration of the camera movement when snapping to the target (0 for instant snap)
  import static attribute float       TargettingAcceleration;
  
  //
  // Targeting functions and properties.
  // There may be only one target at a given moment. When the target is set
  // and camera is not locked to real coordinates, it will try reaching
  // (centering) at the target, using linear acceleration to move faster every
  // game frame.
  //
  
  /// Use built-in viewport control (target on player)
  import static attribute bool        DefaultTarget;
  /// Target character, or null
  import static attribute Character  *TargetCharacter;
  /// Target room object, or null
  import static attribute Object     *TargetObject;
  /// Target dynamic location, or null
  import static attribute Point      *TargetLocation;
  
  /// Assign room coordinates as a target
  import static void                  SetStaticTarget(int x, int y);
  /// Get if static target is set
  import static readonly attribute bool StaticTarget;
  
  /// Limits to camera movement, camera cannot move past these
  import static void                   SetBounds(int x1, int y1, int x2, int y2);
  /// Resets bounds to default (imposed by the room size)
  import static void                   ResetBounds();
  /// Get current camera movement bounds
  import static readonly attribute int BoundsLeft;
  import static readonly attribute int BoundsRight;
  import static readonly attribute int BoundsTop;
  import static readonly attribute int BoundsBottom;
  
  //
  // Custom panning control.
  // Camera module's custom movement works opposite to built-in viewport controls
  // in AGS: when locked it follows the target, and when released it stays at one
  // spot unless told to move.
  //
  
  /// Locks camera to target
  import static void                  Lock();
  /// Releases camera and enables free movement on demand
  import static void                  Release();
  /// Immediately snap to the target
  import static void                  Snap();
  
  /// Sets camera center at given room coordinates
  import static void                  CenterAt(int x, int y);
  /// Sets camera left-top corner at given room coordinates (same as SetViewport)
  import static void                  ViewportAt(int x, int y);
  
  //
  // Custom zoom control.
  // Neither AGS nor our game currently do not support viewport zooming.
  // Until it happens, we indicate zoom using rectangle overlay (helps debugging)
  //
  
  /// Get/set camera zoom, in percents to default (eq. native game size)
  import static attribute float       Zoom;
  
  //
  // State control
  //
  
  /// Gets room coordinates of camera's display center
  import static readonly attribute int CameraX;
  import static readonly attribute int CameraY;
  /// Gets room coordinates of camera's vision width and height
  import static readonly attribute int CameraWidth;
  import static readonly attribute int CameraHeight;
  /// Gets whether camera is currently following the target
  import static readonly attribute bool LockedToTarget;
  /// Coordinates of actual target point; these are dynamically updated
  /// for object targets, or equal to static target
  import static readonly attribute int TargetX;
  import static readonly attribute int TargetY;
};


/// FreeLook static struct manages free camera panning, controlled by user input (like mouse).
struct FreeLook
{
  /// Enable or disable free look
  import static attribute bool Enabled;
};


/// CameraAction static struct manages various camera moves in a blocking or non-blocking ways.
struct CameraAction
{
  /// Instantly point camera to the given room coordinates and lock in position
  import static void Pos(int x, int y);
  /// Pans camera to center at the given room coordinates
  import static void Pan(int x, int y, float speed, float accel, BlockingStyle block);
  /// Zooms and repositions camera onto direction of given point by step calculated with
  /// assumption that movement is proportional to zooming and the end point is to be
  /// reached at the given end zoom.
  import static void LinearZoomOnto(int x, int y, float next_zoom, float reach_at_zoom);
};
