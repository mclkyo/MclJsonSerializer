Pod::Spec.new do |s|  
  s.name             = "MclJsonSerializer" 
  s.version          = "1.0.5"  
  s.summary          = "Parse Object 2 Json String."  
  s.description  = <<-DESC
		Parse Object 2 Json String.
		You can Parse NSobject,NSArray,NSDictory
		it will get all property in nsobject and parse to NSDictory and Convert to Json use NSJSONSerialization (ios 5.0)
                   DESC
  s.homepage         = "https://github.com/mclkyo/MclJsonSerializer"  
  s.license          = "MIT"  
  s.author           = { "mclkyo" => "mclkyo@gmail.com" }  
  s.source           = { :git => "https://github.com/mclkyo/MclJsonSerializer.git", :tag => "1.0.5"}  
  s.platform     = :ios, "7.0"  
  s.requires_arc = true  
  s.source_files = "MclJsonSerializerDemo/Lib/**/*.{h,m}"

  
end