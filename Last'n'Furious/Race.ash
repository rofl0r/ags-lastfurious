
#define MAX_RACING_CARS 6
#define MAX_RACING_CARS_SQUARED 36
#define MAX_CHECKPOINTS 200

enum AiAndPhysicsOption
{
  ePhysicsSafe, 
  ePhysicsWild
};

// Race & player setup
struct Race
{
  int Laps;
  int Opponents;
  int PlayerDriver; // player's character
  AiAndPhysicsOption AiAndPhysics;
  bool CarCollisions;
  
  int DriverPositions[MAX_RACING_CARS];
  int RacersFinished;
};

// Used to detect car placements
struct RaceNode
{
  VectorF *pt;
  int order;
  int prev;
  int next;
  
  import void Reset();
};

// Participant info
struct Racer
{
  bool IsActive;
  int Driver; // character
  int Lap;
  int Place;
  float Time;
  int Finished;
  
  int CurRaceNode;
  int CheckptsPassed;
  
  import void Activate(int driver);
  import void Reset();
  import void SwitchToNextNode();
};

import bool HoldRace;

import RaceNode Checkpoints[MAX_CHECKPOINTS];
import int FirstCheckpt;
import int LastCheckpt;
import int CheckptCount; // number of nodes in use
import int FreeCheckptSlot; // first free slot

import int  FindFirstFreeCheckpoint();
import void LoadRaceCheckpoints();
import void SaveRaceCheckpoints();

import void OnLapComplete(int racer);

import Race ThisRace;
import Racer Racers[MAX_RACING_CARS];
import Vehicle Cars[MAX_RACING_CARS];
