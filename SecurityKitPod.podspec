

Pod::Spec.new do |spec|


  spec.name         = "personalSecurityKit"
  spec.version      = "1.0.2"
  spec.summary      = "A short description of personalSecurityKit. app!"


   spec.description  = <<-DESC
 personalSecurityKit 是一个用于验证加密算法的内容 
			DESC

  spec.homepage     = "https://github.com/zhixuan/personalSecurityKit.git"




  spec.license      = { :type => "MIT", :file => "LICENSE" }



  spec.author             = { "zhangliguang" => "zhangliguang1@hotmail.com" }
  
  # spec.platform     = :ios
   spec.platform     = :ios, "8.1"



  spec.source       = { :git => "https://github.com/zhixuan/personalSecurityKit.git", :tag => "1.0.2" }



  spec.source_files  = 'personalSecurityKit/*'
 

  # spec.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
