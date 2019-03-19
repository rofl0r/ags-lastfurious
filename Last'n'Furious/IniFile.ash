/****************************************************************
 * Ini file module                                              *
 *                                                              *
 * Author: Ferry "Wyz" Timmers                                  *
 * Date: 31-7-2012                                              *
 * Description: Loads, saves and alters ini configuation files. *
 * Requirements: None                                           *
 * License: zlib license, see below.                             *
 *                                                              *
 ****************************************************************/

/*
 * NOTE: The configuration is not saved automatically!
 *       Please call 'Save' after you're done changing the configuration.
 *
 * Notes:
 * - Supports basic windows ini files
 * - All section and key names are case insensitive
 * - section names may contain any character but ]
 * - key names may contain any character but [ and = and ;
 * - values can not contain leading/trailing whitespace
 *
 * Reading:
 * - Section names should not be prefixed by spaces
 * - Comments are supported and start with a semicolon
 * - Comments after values are not supported
 * - Escaped and quoted values unsupported (though support can be added)
 * - Boolean values supported: true/false, on/off, yes/no, 1/0 (case insensitive)
 *
 * Writing:
 * - section and key names should be valid, this is not checked
 * - values should be serialized when containing special characters
 * - boolean values are stored as 1 and 0
 *
 * The buffer size should be big enough to store the complete configuration,
 * when this is not the case the module will fail silently and overflowing settings will not be stored.
 * A typical ini file does not exceed 50 lines;
 * when your usage does please change the constant below accordantly.
 *
 */

/// Sets the size of the internal line buffer
#define INIFILE_BUFFER_SIZE 250

struct IniFile
{
  /// Loads an ini file from disk; returns success.
  import bool Load(String filename);
  /// Saves the current configuration to disk; returns success.
  import bool Save(String filename);
  /// Clears the current configuration
  import void Clear();
  
  /// Stores the section names in a list with specified size. Returns the number of sections (regardless the list size).
  import int ListSections(String list[], int size);
  /// Stores the key names of the requested section in a list with specified size. Returns the number of keys (regardless the list size).
  import int ListKeys(String section, String list[], int size);
  
  /// Returns whether the given section exists in the current configuration.
  import bool SectionExists(String section);
  /// Deletes the given section from the current configuration (when it exists).
  import void DeleteSection(String section);
  /// Returns whether the given key exists in the given section of the current configuration.
  import bool KeyExists(String section, String key);
  /// Deletes the given key from the given section in the current configuration (when it exists).
  import void DeleteKey(String section, String key);
  
  /// Reads a value from the current configuration and returns it when it exists; returns the supplied default value when it does not.
  import String Read(String section, String key, String value = 0);
  /// Reads an integer from the current configuration and returns it when it exists; returns the supplied default integer when it does not.
  import int ReadInt(String section, String key, int value = 0);
  /// Reads a float from the current configuration and returns it when it exists; returns the supplied default float when it does not.
  import float ReadFloat(String section, String key, float value = 0);
  /// Reads a boolean from the current configuration and returns it when it exists; returns the supplied default value when it does not.
  import bool ReadBool(String section, String key, bool value = false);
  
  /// Writes a value to the current configuration and returns success. It tries to make a new section when the given one does not exist.
  import bool Write(String section, String key, String value);
  /// Writes an integer to the current configuration and returns success. It tries to make a new section when the given one does not exist.
  import bool WriteInt(String section, String key, int value);
  /// Writes a float to the current configuration and returns success. It tries to make a new section when the given one does not exist.
  import bool WriteFloat(String section, String key, float value);
  /// Writes a boolean to the current configuration and returns success. It tries to make a new section when the given one does not exist.
  import bool WriteBool(String section, String key, bool value);
  
  // Private variables
  String lines[INIFILE_BUFFER_SIZE]; // $AUTOCOMPLETEIGNORE$
  int length; // $AUTOCOMPLETEIGNORE$
};

/*
 * Copyright (c) 2012 Ferry "Wyz" Timmers
 *
 * This software is provided 'as-is', without any express or implied
 * warranty. In no event will the authors be held liable for any damages
 * arising from the use of this software.
 * 
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 * 
 *    1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software
 *    in a product, an acknowledgment in the product documentation would be
 *    appreciated but is not required.
 * 
 *    2. Altered source versions must be plainly marked as such, and must not be
 *    misrepresented as being the original software.
 * 
 *    3. This notice may not be removed or altered from any source
 *    distribution.
 */
