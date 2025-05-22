#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint mobile_number_picker.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'phone_number_picker'
  s.version          = '0.0.2'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'https://github.com/dartcoders/MobileNumberPicker'
  s.license          = { :type => 'BSD', :file => '../LICENSE' }
  s.author           = { 'Manish' => 'manish.kummar21@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'
  s.swift_version = '5.0'
end
