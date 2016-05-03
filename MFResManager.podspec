#
# Be sure to run `pod lib lint MFResManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MFResManager"
  s.version          = "1.0.1"
  s.summary          = "MFResManager is a compact iOS utility library to access ressources in an application."
  s.description      = <<-DESC
MFResManager is a compact iOS Utility Library to access ressources in an application.

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
                       DESC
  s.homepage         = "https://github.com/moosefactory/MFResManager"
  s.license          = 'MIT'
  s.author           = { "Tristan Leblanc" => "tristan@moosefactory.eu" }
  s.source           = { :git => "https://github.com/moosefactory/MFResManager.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/moosefactory_eu'

    s.ios.deployment_target = '7.0'
    s.requires_arc = true
    s.framework    = 'SystemConfiguration'

  s.source_files = 'MFResManager/*'
end
