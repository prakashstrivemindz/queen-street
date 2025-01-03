# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Queen St' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Queen St

  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'IQKeyboardManagerSwift'
  pod 'ReachabilitySwift'
  pod 'NVActivityIndicatorView', '~> 4.4.0'
  pod 'SDWebImage'
  pod 'SwiftyGif'
  pod 'SideMenuSwift'
  pod 'DropDown'
  
  target 'Queen StTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Queen StUITests' do
    # Pods for testing
  end

  post_install do |installer|
      installer.generated_projects.each do |project|
            project.targets.each do |target|
                target.build_configurations.each do |config|
                    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
                 end
            end
     end
  end
end
