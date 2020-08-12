#
#  Be sure to run `pod spec lint PullDownListSwift.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "PullDownListSwift"
  spec.version      = "1.0.1"
  spec.swift_version      = "5.0"
  spec.summary      = "PullDownListSwift 给按钮或输入框添加选择列表弹框，输入框右侧图片按钮"
  spec.description  = <<-DESC
                            PullDownListSwift 是一个添加列表选择弹框和文本框右侧图片按钮的控件封装
                        DESC
  spec.homepage     = "https://github.com/CMlinksuccess/PullDownListSwift"
  spec.license      = 'MIT'
  spec.author       = { "xiaowanjia" => "myemil0@163.com" }
  spec.source       = { :git => "https://github.com/CMlinksuccess/PullDownListSwift.git", :tag => spec.version }
  spec.platform     = :ios, '9.0'
  spec.requires_arc = true
  spec.resource  = 'pullDownListSwift.bundle'
  spec.source_files  = 'PullDownListSwift/PullDownListSwift/*.{swift,h,bundle}'
  spec.frameworks = 'UIKit'
  
end
