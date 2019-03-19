
enum MenuClass
{
  eMenuNone, 
  eMenuStart, 
  eMenuMain, 
  eMenuMainInGame, 
  eMenuSetupRace, 
  eMenuCredits
};

// Room exports
enum Room305Events
{
  eRoom305_StartSinglePlayer, 
  eRoom305_StartAIDemo
};

import SpriteFont SilverFont;
import SpriteFont AzureItalicFont;
import SpriteFont PurpleItalicFont;

import void DisplayGameMenu(MenuClass menu, bool pausedInGame = false);
import void HideGameMenu();

import void SetMusic(int vol);
import void SetEffects(int vol);

import bool IsDebugMode;

import void SetDefaultOptions();
import void LoadOptions();
import void SaveOptions();
