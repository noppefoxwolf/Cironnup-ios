platform :ios, '12.0'
use_frameworks!

pod 'SwiftGen'
pod 'AppIconGen'
pod 'LicensePlist'

workspace 'gabbie-ios.xcworkspace'
project 'gabbie-ios.xcodeproj'
project 'CironnupKit/CironnupKit.xcodeproj'
project 'CironnupUI/CironnupUI.xcodeproj'

target 'gabbie-ios' do
  project 'gabbie-ios.xcodeproj'
  pod 'GabKit'
  pod 'Fakery'
  pod '1PasswordExtension'
  
  target 'gabbie-ShareExtension' do
  end
end

target 'CironnupUI' do
  project 'CironnupUI/CironnupUI.xcodeproj'
end

target 'CironnupKit' do
  project 'CironnupKit/CironnupKit.xcodeproj'
  pod 'GabKit'
end
