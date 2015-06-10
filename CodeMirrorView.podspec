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

  s.source       = { :git => "https://github.com/artifacts/CodeMirrorView.git", :tag => s.version.to_s }


  s.source_files  = 'Distribution/*.{h,m}'

  s.resources = "Distribution/CodeMirrorView.bundle"

  s.framework  = 'WebKit'

  s.requires_arc = true

end
