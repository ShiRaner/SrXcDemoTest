 Pod::Spec.new do |spec|

  
  spec.name         = "XcSDKTest"  # 1 存储库名称
  spec.version      = "0.0.1"      # 2 版本号 与 tag 值一致
  spec.summary      = "测试SDK"  # 3 简介
  spec.description  = "这是一个测试SDK"  # 4 描述
  spec.homepage     = "http://EXAMPLE/XcSDKTest"  # 5 项目主页 不是 git 地址
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }  # 6 开源协议
  spec.author       = { "ShiRaner" => "1129748463@qq.com" } # 7 作者
  spec.platform     = :ios, "8.0"    # 8 支持的平台和版本号
  spec.source       = { :git => "http://EXAMPLE/XcSDKTest.git", :tag => "#{spec.version}" }  # 存储库的 git 地址 以及 tag 值
  spec.source_files  = "Classes", "Classes/**/*.{h,m}" # 需要托管的源代码路径
  spec.exclude_files = "Classes/Exclude"
  spec.requires_arc = true  # 是否使用 arc
  
  
end