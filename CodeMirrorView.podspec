Pod::Spec.new do |s|

  s.name         = "CodeMirrorView"
  s.version      = "0.0.1"
  s.summary      = "CodeMirrorView is a Cocoa / Objective-C wrapper for CodeMirror ready to use in your applications."

  s.description  = <<-DESC
                   CodeMirrorView is a Cocoa / Objective-C wrapper for CodeMirror ready to use in your applications. 
		   Simply add the "Distribution" directory as a group to your Xcode project then use the "CodeMirrorView" class where needed as any regular NSView.
		   See the Application directory for an example app.	 
		   DESC

  s.homepage     = "https://github.com/swisspol/CodeMirrorView"
  s.license      = 'Copyright (c) 2013, Pierre-Olivier Latour'

  s.author       = { "Pierre-Olivier Latour" => "todo@todo.com" }

  s.platform     = :osx

  s.osx.deployment_target = '10.8'

  s.source       = { :git => "https://github.com/artifacts/CodeMirrorView.git", :tag => "0.0.1" }


  s.source_files  = 'Distribution/*.{h,m}'

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  s.resources = "Distribution/CodeMirrorView.bundle"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  s.framework  = 'WebKit'


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  s.requires_arc = true

  #s.prefix_header_file = ''

  # s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
  #s.xcconfig = { 'OTHER_LDFLAGS' => '-all_load' }
  
end
