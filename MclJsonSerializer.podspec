Pod::Spec.new do |s|  
  s.name             = "MclJsonSerializer" 
  s.version          = "1.0.0"  
  s.summary          = "Parse Object 2 Json String."  
  s.description  = <<-DESC
                   DESC
  s.homepage         = "https://github.com/mclkyo/MclJsonSerializer"  
  s.license          = "MIT"  
  s.author           = { "mclkyo" => "mclkyo@gmail.com" }  
  s.source           = { :git => "https://github.com/mclkyo/MclJsonSerializer.git", :tag => "1.0.0"}  
  s.platform     = :ios, "7.0"  
  s.requires_arc = true  
  s.source_files = "MclJsonSerializerDemo/Lib/**/*.{h,m}"

  
end