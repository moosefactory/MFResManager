![MacDown logo](https://www.moosefactory.eu/resources/MooseFactoryRoundLogo.png)

**Resources Loading Library for iOS**


MFResManager is a compact iOS Utility Library to access ressources in an application.
This framework is compact, and composed of only three classes:

MFResGetter:
---------------
- Access ressouces ( texts, images, videos .. ) in a safe way - avoiding the annoying NULL url exception.
- Provide a log for missing resources and a mechanism to return a generic resource in replacement
- Provide an imageNamed: method more powerful than the default one, that loads jpg,png and tifs

MFKeyResGetter:
---------------
- Provides the same features than MFResGetter, but adds a localized media handling via a table of content

MFKeyResFileLogger:
---------------
- Log to console, or files. This logger is used by the ResGetter classes, but can't be used individually


Tristan Leblanc - MooseFactory Software  
<https://www.moosefactory.eu>

##Author

Tristan Leblanc <tristan@moosefactory.eu>

Twitter     :	<https://www.twitter.com/tristanleblanc>  
Google+     :	<https://plus.google.com/+TristanLeblanc>  

GitHub       :   <https://github.com/moosefactory>


***

##License

MFFoundation is available under the MIT license. See the LICENSE file for more info.

***
