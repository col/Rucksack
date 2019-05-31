#
# Be sure to run `pod lib lint Rucksack.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Rucksack'
  s.version          = '0.1.0'
  s.summary          = 'An opinionated JSONAPI client library written in Swift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
An opinionated JSONAPI client library written in Swift.

*WIP* This library is still very much a work in progress.
Trying to decode a dynamic specification like the JSONAPI using a strictly typed language like Swift
provides some interesting challenges. This library is mostly an exercise in how or if these can be overcome.
                       DESC

  s.homepage         = 'https://github.com/col/Rucksack'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'col' => 'col.w.harris@gmail.com' }
  s.source           = { :git => 'https://github.com/col/Rucksack.git', :tag => s.version.to_s }

  s.swift_versions = '5.0'
  s.ios.deployment_target = '11.0'

  s.source_files = 'Rucksack/Classes/**/*'

  # s.resource_bundles = {
  #   'Rucksack' => ['Rucksack/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
