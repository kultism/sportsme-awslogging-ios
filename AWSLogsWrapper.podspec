#
# Be sure to run `pod lib lint AWSLogsWrapper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AWSLogsWrapper'
  s.version          = '1.0.6'
  s.summary          = 'A utility class on top of AWSLogs to store the logs in Local DB and then sending to CloudWatch.'
  s.swift_version    = '5.0'
  s.homepage         = 'https://github.com/kultism/sportsme-awslogging-ios'
  s.license          = { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.source           = { :git => 'https://github.com/kultism/sportsme-awslogging-ios.git', :tag => s.version.to_s }
  s.author           = { "Rajasekhar Pattem" => "rajasekhar.pattem@tarams.com" }
  s.ios.deployment_target = '11.0'
  s.source_files = 'AWSLogsWrapper/Classes/**/*'
  s.dependency 'AWSLogs'
  s.dependency 'RealmSwift'
end
