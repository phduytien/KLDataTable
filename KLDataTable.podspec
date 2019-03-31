#
# Be sure to run `pod lib lint KLDataTable.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'KLDataTable'
    s.version          = '0.1.0'
    s.summary          = 'A short description of KLDataTable.'
    s.description      = <<-DESC
    Customize UITableView for displaying multiple columns in UITableViewCell.
    DESC
    s.requires_arc = true
    s.homepage         = 'https://github.com/phduytien/KLDataTable'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Tien Pham' => 'phduytien4891@gmail.com' }
    s.source           = { :git => 'https://github.com/phduytien/KLDataTable.git', :tag => s.version.to_s }
    s.social_media_url = 'https://www.facebook.com/phduytien'
    s.ios.deployment_target = '9.3'
    s.source_files = 'KLDataTable/Classes/**/*'
    s.frameworks = 'UIKit'
    s.dependency 'SnapKit', '~> 4.0'
    s.dependency 'RxSwift', '~> 4.0'
    s.dependency 'RxCocoa', '~> 4.0'
    s.dependency 'Material', '~> 2.12'
    s.dependency 'FontAwesomeKit'
    s.dependency 'AlamofireObjectMapper', '~> 5.0'
    s.dependency 'DRPLoadingSpinner'
    s.dependency 'SwiftMaterialKeyboard', '~> 0.1'
    s.swift_version = '4.0'
end
