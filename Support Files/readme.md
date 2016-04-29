# MFFoundation

![MacDown logo](https://www.moosefactory.eu/resources/MooseFactoryRoundLogo.png)

**Utility static library for iOS or MacOS**


This is a compilation of some of commonly used codes over the years.  
Feel free to contact me by email at <tristan@moosefactory.eu>

Cheers :)

Tristan Leblanc - MooseFactory Software  
<https://www.moosefactory.eu>

***

## DISCLAIMER

Not everything is documented and tested yet.  
Work is in progress. This disclaimer should disapear quite soon ;)

***

## Table of Content

***

**MFExtras**
 
* NSArray+MFExtras
    * arrayByRemovingLastObject
    * arrayByRemovingFirstObject
    * alphabeticallySortedArray
* NSData+MFExtras
    * dataWithBytesString:
    * bytesString
    * randomDataOfLength:
* NSDate+MFExtras
    * dateByClearingTime
    * dateBySettingHour:
    * isSameDayAsDate:
    * isSameMonthAsDate:
    * oneMonthLater
    * oneMonthEarlier
    * oneDayLater
    * oneDayEarlier
    * secondsSinceStartOfDay
    * components
* NSDictionary+MFExtras
    * dictionaryWithName:
    * dictionaryWithName:
    * localizedDictionaryWithName:
    * localizedDictionaryWithName:
    * alphabeticallySortedKeys
* NSFileManager+MFExtras
    * isDirectoryEmpty:
* NSString+MFExtras
    * UUIDString
    * md5
    * sha1
    * isValidEmail:
    * isValidName
    * urlEncode
    * urlDecode

***

**Date and Formatters**
 
* MFChronoTimeFormatter
* MFDateUtils
* MFFormatters
* MFLatLongFormatter

**Graphics**

* MFCombinedColor

***

**Types**
 
* MFTypes
* MFDateRange
* MFPeriod

***

**Maths**
 
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

##Installation

MFFoundation is available through CocoaPods. To install it, simply add the following line to your Podfile:

>pod 'MFFoundation'

***

##Contribute

If you wish to contribute, check the CONTRIBUTE<CONTRIBUTE.md> file for more information.

***

##License

MFFoundation is available under the MIT license. See the LICENSE file for more info.

***

*Preliminary document - Updated 03/13/2016*