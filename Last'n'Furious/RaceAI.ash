
#define MAX_PATH_NODES 200
#define DEFAULT_PATH_CHECK_RADIUS 50.0

enum AIType
{
  eAINone, 
  eAIPaths, 
  eAIRegions
};

struct PathNode
{
  VectorF *pt;
  float radius; // radius at which vehicle may "check in" this node
  float threshold; // radius at which vehicle may stop turning towards center of the node
  float speed; // recommended speed after this node (< 0 means any speed)
  int prev;
  int next;
  
  import void Reset();
};

struct RaceAI
{
  int vehicleIndex;
  VectorF *targetPos;
  VectorF *targetDir;
  float targetCheckRadius;
  float targetThreshold;
  float targetSpeedHint;
  int currentNode;
  
  import void Reset();
  import void Run(float deltaTime);
  
  protected import bool TestShouldChooseNewTarget();
  protected import bool ChooseNewTarget();
  protected import void DriveToTheTarget();
};

struct RaceAIRegionBased
{
  int vehicleIndex;
  float targetAngle;
  
  import void Reset();
  import void Run(float deltaTime);
};

import AIType ActiveAIType;
import bool HoldAI;
import RaceAI RobotsPB[MAX_RACING_CARS];
import RaceAIRegionBased RobotsRB[MAX_RACING_CARS];

import PathNode Paths[MAX_PATH_NODES];
import int FirstPathNode;
import int LastPathNode;
import int PathNodeCount; // number of nodes in use
import int FreePathSlot; // first free slot

import int  FindFirstFreeNode();
import void LoadAIPaths();
import void SaveAIPaths();

import void LoadAIRegions();

import void LoadAI();
import void AssignAIToCar(int car_index);
import bool IsAIEnabledForCar(int car_index);
import void DisableAIForCar(int car_index);

import void ResetAI();


struct ColorToAngle
{
  int rgb[3]; // original rgb
  int color; // AGS native color index
  float angle; // direction angle
};

import ColorToAngle RegionAngles[16];
import DynamicSprite *AIRegions;
import DrawingSurface *AIRegionsDS;
