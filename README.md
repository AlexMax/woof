# This is Woof!
[![Woof! Icon](https://raw.githubusercontent.com/fabiangreffrath/woof/master/data/woof.png)](https://github.com/fabiangreffrath/woof)

[![Travis Build Status](https://img.shields.io/travis/com/fabiangreffrath/woof.svg?style=flat&logo=travis)](https://travis-ci.com/fabiangreffrath/woof/)

Woof! is a continuation of Lee Killough's Doom source port MBF targeted at modern systems.

## Synopsis

[MBF](https://doomwiki.org/wiki/MBF) stands for "Marine's Best Friend" and is regarded by many as the successor of the Boom source port by TeamTNT. It serves as the code base for many of today's successful Doom source ports such as [PrBoom+](https://github.com/coelckers/prboom-plus) or [The Eternity Engine](https://github.com/team-eternity/eternity). As the original engine was limited to run only under MS-DOS, it has been ported to Windows by Team Eternity under the name [WinMBF](https://github.com/team-eternity/WinMBF) in 2004. Woof! is developed based on the WinMBF code with the aim to make MBF more widely available and convenient to use on modern systems.

To achieve this goal, this source port is less strict regarding its faithfulness to the original MBF. It is focused on quality-of-life enhancements, bug fixes and compatibility improvements. However, all changes have been introduced in good faith that they are in line with the original author's intentions and even for the trained eye, this source port should be hard to distinguish from the original MBF.

In summary, this project's goal is to forward-port MBF.EXE from DOS to year 2020 and remove all the stumblings blocks on the way.

## What's with the name?

If you turn the [Doom logo upside down](https://www.reddit.com/r/Doom/comments/8476cr/i_would_so_olay_wood/) it reads "Wood" - which would be a pretty stupid name for a source port. "Woof" is just as stupid a name for a source port, but at least it contains a reference to dogs - and dogs are the Marine's Best Friend. ;-)

# Code changes

The following code changes have been introduced in Woof! relative to MBF or WinMBF, respectively.

## General improvements

 * The code has been made 64-bit compatible.
 * The code has been ported to SDL-2, the game scene is now rendered to screen using hardware acceleration (if available).
 * The build system has been ported to CMake with support for building on Linux and Windows, using either MSVC or MinGW and the latter either in a cross-compiling or a native MSYS2 environment (@AlexMax).
 * Fullscreen mode can be toggled in the General menu section or by pressing <kbd>Alt</kbd>+<kbd>Enter</kbd>, and it is now saved in the config file.
 * The complete SDL input and event handling system has been overhauled based on code from Chocolate Doom 3.0 (mouse acceleration is disabled since Woof! 1.1.0).
 * The search path for IWADs has been adapted to modern requirements, taking the install locations for common download packages into account.
 * On non-Windows systems, volatile data such as config files and savegames are stored in a user writable directory.
 * On Windows systems, support for dragging and dropping WAD and DEH files onto the executable has been added (fixed in Woof! 1.0.1).
 * If the SDL2_Image library is found at runtime, screnshots may be saved in PNG format.
 * The sound system has been completely overhauled, letting SDL_Mixer do the actual sound mixing and getting rid of the fragile sound channel locking mechanism.
 * The original Spectre/Invisibility fuzz effect has been brought back.
 * The flashing disk icon has been brought back.
 * Error messages now appear in a pop-up window.
 * All non-free embedded lumps have been either removed or replaced.
 * Support for helper dogs and beta emulation is now unconditionally enabled.
 * 32 MiB are now allocated by default for zone memory.
 * The rendering of flats has been improved (visplanes with the same flats now match up far better than before and the distortion of flats towards the right of the screen has been fixed, since Woof! 1.1.0).

## Input

 * Support for up to 5 mouse buttons and up to 12 joystick buttons has been added.
 * Keyboard and mouse bindings for prev/next weapon have been added (bound to buttons 4 and 5, resp. the mouse wheel), joystick bindings for strafe left/right have been added (bound to buttons 5 and 6), joystick bindings for prev/next weapon have been added (prev weapon bound to button 3), joystick bindings for the automap and the main menu have been added.
 * Key and button bindings may be cleared in the respective menu by using the <kbd>DEL</kbd> key.
 * Movement keys are bound to the WASD scheme by default.
 * Menu control by mouse has been disabled.

## Bug fixes

 * The famous "3-key door opens with only two keys" bug has been fixed with a compatibility flag.
 * A crash when returning from the menu before a map was loaded has been fixed.
 * A crash when loading a trivial single subsector map has been fixed.
 * A crash when playing back too short demo lumps (e.g. sunlust.wad) has been fixed.
 * A crash when the attack sound for the Lost Soul is missing has been fixed (e.g. ludicrm.wad MAP05).
 * A bug in the translucency table caching has been fixed which would lead to garbled translucency effects for WAD files with custom PLAYPAL lumps.
 * Playback of Vanilla Doom demos has been vastly improved.

## Support for more WAD files

 * The IWAD files shipped with the "Doom 3: BFG Edition" and the ones published by the Freedoom project are now supported.
 * The level building code has been upgraded to use unsigned data types internally, which allows for loading maps that have been built in "extended nodes" format. 
 * Furthermore, maps using nodes in DeePBSP and (compressed or uncompressed) ZDBSP formats can now be loaded.
 * The renderer has been upgraded to use 32-bit integer variables internally, which fixes crashes in levels with extreme heights or height differences (e.g. ludicrm.wad MAP03).
 * A crash when loading maps with too short REJECT matrices has been fixed.
 * The port is now more forgiving when composing textures with missing patches (which will be substituted by a dummy patch) or empty columns (which will be treated as transparent areas).
 * The port is now more forgiving when a flat lump cannot be found and renders the sky texture instead (since Woof! 1.1.0).
 * Some nasty rendering and automap glitches have been fixed which became apparent especially in extremely huge levels (e.g. planisf2.wad, since Woof! 1.1.0).

## Known issues

 * Savegames stored by a 64-bit executable cannot be restored by a 32-bit executable - and are thus incompatible with the original MBF. This is because raw struct data is stored in savegames, and these structs contain pointers, and pointers have different sizes on 32-bit and 64-bit architectures.
 * IWAD files of Doom version 1.1 and earlier are not supported anymore, as they are missing lumps that are not embedded into the executable anymore (support for Doom 1.2 since Woof! 1.0.1).

# Download

The Woof! source code is available at GitHub: https://github.com/fabiangreffrath/woof.

It can cloned via

```
 git clone https://github.com/fabiangreffrath/woof.git
```

## Linux

You will need to install the SDL2, SDL2_mixer and SDL2_net libraries.  Usually your distribution has these libraries in its repositories, and if your distribution has "dev" versions of those libraries, those are the ones you'll need.

Once installed, compilation should be as simple as:

```
 cd woof
 mkdir build; cd build
 cmake -G "Unix Makefiles" ..
 make
```

After successful compilation the resulting binary can be found in the `Source/` directory.

## Windows

Visual Studio 2019 comes with built-in support for CMake by opening the source tree as a folder.  Otherwise, you should probably use the GUI tool included with CMake to set up the project and generate build files for your tool or IDE of choice.

CMake will almost certainly not be able to find SDL libraries by default.  You will want to download the Windows development libraries for SDL2, SDL2_mixer, and SDL2_net.  After you do so, extract them someplace, and then point the `SDL2_DIR`, `SDL2_MIXER_DIR` and `SDL2_NET_DIR` cache variables at the root directory of those extracted libraries.  CMake should fill out the missing pieces.

# Contact

The canonical homepage for Woof! is https://github.com/fabiangreffrath/woof

Woof! is maintained by [Fabian Greffrath](mailto:fabian@greffXremovethisXrath.com). 

Please report any bugs, glitches or crashes that you encounter to the GitHub [Issue Tracker](https://github.com/fabiangreffrath/woof/issues).

## Acknowledgement

MBF has always been a special Doom source port for me, as it tought me how to implement 640x400 resolution rendering which was the base for my own source port project [Crispy Doom](https://github.com/fabiangreffrath/crispy-doom). As the original MBF was limited to run only under MS-DOS, I used its pure port WinMBF by Team Eternity to study and debug the code. Over time, I got increasingly frustrated that the code would only compile and run on 32-bit systems and still use the meanwhile outdated SDL-1 libraries. This is how this project was born.

Many additions and improvements to this source port were taken from fraggle's [Chocolate Doom](https://www.chocolate-doom.org/wiki/index.php/Chocolate_Doom), taking advantage of its exceptional portability, accuracy and compatibility.

# Legalese

Files: `*`  
Copyright: © 1993-1996 Id Software, Inc.;  
 © 1993-2008 Raven Software;  
 © 1999 by id Software, Chi Hoang, Lee Killough, Jim Flynn, Rand Phares, Ty Halderman;  
 © 2004 James Haley;  
 © 2005-2014 Simon Howard;  
 © 2020 Fabian Greffrath;  
 © 2020 Alex Mayfield.  
License: [GPL-2.0+](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html)

Files: `Source/beta.c`  
Copyright: © 2001-2019 Contributors to the Freedoom project.  
License: [BSD-3-Clause](https://opensource.org/licenses/BSD-3-Clause)

Files: `Source/dogs.c`  
Copyright: © 2017 Nash Muhandes;  
 © apolloaiello;  
 © TobiasKosmos.  
License: [CC-BY-3.0](https://creativecommons.org/licenses/by/3.0/) and [CC0-1.0](https://creativecommons.org/publicdomain/zero/1.0/)

Files: `data/woof.ico,  
 data/woof.png,  
 data/woof8.ico,  
 Source/icon.c`  
Copyright: © 2020 Julia Nechaevskaya.  
License: [CC-BY-3.0](https://creativecommons.org/licenses/by/3.0/)

Files: `cmake/FindSDL2.cmake,  
 cmake/FindSDL2_mixer.cmake,  
 cmake/FindSDL2_net.cmake`  
Copyright: © 2018 Alex Mayfield.  
License: [BSD-3-Clause](https://opensource.org/licenses/BSD-3-Clause)
