
![MacDown logo](https://www.moosefactory.eu/resources/MooseFactoryRoundLogo.png)

MooseFactory Software  
<https://www.moosefactory.eu>

# MFResManager
**Resources Loading Library for iOS**

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


##License

MFResManager is available under the MIT license. See the LICENSE file for more info.

***

##Author

Tristan Leblanc <tristan@moosefactory.eu>

Twitter     :	<https://www.twitter.com/tristanleblanc>  
Google+     :	<https://plus.google.com/+TristanLeblanc>  

GitHub      :   <https://github.com/moosefactory>

***

