platform :ios, ‘9.3’


target ‘Time-Application’ do

  use_frameworks!
  pod 'Then’,           :git => 'https://github.com/devxoul/Then.git'
  pod 'AsyncSwift',     :git => 'https://github.com/duemunk/Async.git', :branch => ‘feature/Swift_3.0’
  pod 'Alamofire',      :git => 'https://github.com/Alamofire/Alamofire.git'
  pod 'SwiftyJSON',     :git => 'https://github.com/appsailor/SwiftyJSON.git', :branch => 'swift3'
  pod 'Moya',           :git => 'https://github.com/Moya/Moya.git', :branch => ‘swift-3.0’
  pod 'Result',         :git => 'https://github.com/antitypical/Result.git'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
  end
