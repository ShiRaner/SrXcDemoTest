 Pod::Spec.new do |spec|

  spec.name         = "XcSDKTest"  # 1 存储库名称
  spec.version      = "0.0.1"      # 2 版本号 与 tag 值一致
  spec.summary      = "测试SDK"  # 3 简介
  spec.description  = "这是一个测试SDK"  # 4 描述
  spec.homepage     = "https://github.com/ShiRaner/SrXcDemoTest"  # 5 项目主页 不是 git 地址
  spec.license      = { :type => "MIT", :file => "LICENSE" }  # 6 开源协议
  spec.author       = { "ShiRaner" => "1129748463@qq.com" } # 7 作者
  spec.platform     = :ios, "10.0"    # 8 支持的平台和版本号
  spec.source       = { :git => "https://github.com/ShiRaner/SrXcDemoTest.git", :tag => "#{spec.version}" }  # 存储库的 git 地址 以及 tag 值
  spec.source_files  = "XcSDKTest/*.{h,m}"   # 需要托管的源代码路径
  spec.public_header_files = "XcSDKTest/*.h"  #头文件
  # spec.resources  = "XcSDKTest/*.{plist}"  # 资源文件
  spec.requires_arc = true  # 是否使用 arc
  
  
end

