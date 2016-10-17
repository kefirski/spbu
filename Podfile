platform :ios, ‘9.3’


def sharedPods 
  use_frameworks!
  pod 'Then’,           :git => 'https://github.com/devxoul/Then.git'
  pod 'AsyncSwift',     :git => 'https://github.com/duemunk/Async.git', :branch => ‘feature/Swift_3.0’
  pod 'Alamofire',      :git => 'https://github.com/Alamofire/Alamofire.git'
  pod 'SwiftyJSON',     :git => "https://github.com/SwiftyJSON/SwiftyJSON.git"
  pod 'Moya',           :git => "https://github.com/Moya/Moya.git"
  pod 'Result',         :git => 'https://github.com/antitypical/Result.git'
end

target ‘Time-Application’ do 
  sharedPods
end

target ‘TodayTimeApplication’ do
  sharedPods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
  end
