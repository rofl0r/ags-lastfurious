
// Maximal number of timers, change at will (not related to built-in AGS limit).
#define MAX_TIMERS 20

managed struct Timer
{
  /// Start the timer, giving timeout in game ticks.
  import static Timer *Start(int timeout, RepeatStyle repeat = eOnce);
  /// Start the timer, giving timeout in real time (seconds).
  /// Remember that timer can be only as precise as your GameSpeed (40 checks per
  /// second, or 0.025s by default).
  import static Timer *StartRT(float timeout_s, RepeatStyle repeat = eOnce);
  /// Stop the timer
  import void Stop();
  
  /// Tells whether timer is currently active (counting down).
  import readonly attribute bool  IsActive;
  /// Signal property telling that the timer has expired. This flag will remain set
  /// for one game tick only and self-reset afterwards.
  import readonly attribute bool  EvtExpired;
  
  /// Tells whether timer has just expired. Safe to pass null-pointer.
  import static bool   HasExpired(Timer *t);
  /// Stops the running timer. Safe to pass null-pointer.
  import static void   StopIt(Timer *t);
  
  protected int   _id; // internal ID of the timer
  protected bool  _realtime; // is timeout in seconds (otherwise in game ticks)
  protected float _timeout; // timeout (ticks or ms)
  protected bool  _repeat; // should auto-repeat or not
  protected float _remains; // time remaining (ticks or seconds)
  protected bool  _evt; // expired event flag
};
