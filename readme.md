
![MacDown logo](https://www.moosefactory.eu/resources/MooseFactoryRoundLogo.png)

MooseFactory Software  
<https://www.moosefactory.eu>

# MFResManager
**Resources Loading Library for iOS**

A tester project can be found here:
<https://github.com/moosefactory/MFResManager-Tester>

## Introduction
---------------
**MFResManager** is a compact iOS Utility Library providing an alternate way to access ressources in an application.
This framework is composed of only four classes.

The main class,**MFResGetter**, can be used in any project has a replacement to common system methods :

- fileURLWithPath:
- pathForResource:type:
- imageNamed:
- imageWithPath:

The idea is not to patch all the iOS file access methods, but the most commonly used in many projects.

It can be usefull to any developer, but was originaly designed to ease the debugging of multimedia applications dealing with a lot of resources, and languages.

**Set the UIFileSharingEnabled options in your project info to access logs in iTunes, in the application documents section**

## Classes
---------------
### MFResGetter:
---------------
- Access ressouces ( texts, images, videos .. ) in a safe way - avoiding the annoying NULL url exception.

- Provide a log for missing resources and a mechanism to return a generic resource in replacement
- Provide an imageNamed: method more powerful than the default one, that loads jpg,png and tif images

### MFKeyResGetter:  ( WORK IN PROGRESS )
---------------
- Provides the same features than MFResGetter, but adds a localized media handling via a table of content.

### MFResFileLogger:
---------------
- Log to console, or file. 

- This logger is used internally by the ResGetter classes, but can also be used individually.

### MFResCache:
---------------
- Provides a cache system to avoid multiple loading of the same resource.


##Developers
---------------
The MFResManager xCode project is carefully packed.
It shows how to pack a cocoapod spec and automatically build a documentation in a dedicated target using Appledoc and External Build System target type.

**A lot of things are still out my understanding in the way AppleDocs are generated**

So if anyone can teach me anything more on the subject, I'll be glad. 

It also embeds a CocoaPod configuration file (podspec).

###Installation
---------------
MFResManager is available through CocoaPods. To install it, simply add the following line to your Podfile:

>pod 'MFResManager'

###Contribution
---------------

If you wish to contribute, check the CONTRIBUTE<CONTRIBUTE.md> file for more information.

The point of this library is to keep a tight scope, be as fast and as reliable as possible. So if you plan to add many features, please do your way with your own branche.

If you think a feature is a must-have, propose it!


###License
---------------

MFResManager is available under the MIT license. See the LICENSE file for more info.


##Author
---------------
Tristan Leblanc <tristan@moosefactory.eu>

Twitter     :	<https://www.twitter.com/tristanleblanc>  
Google+     :	<https://plus.google.com/+TristanLeblanc>  

GitHub      :   <https://github.com/moosefactory>

---------------

