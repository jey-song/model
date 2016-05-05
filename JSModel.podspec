Pod::Spec.new do |s|
  s.name                = "JSModel"
  s.version             = "0.1.2"
  s.summary             = "JSModel is base model <json string <-> model>. Use key-value coding"
  s.description         = <<-DESC
                          JSModel is base model <json string <-> model>. Use key-value coding"
                          DESC
  s.homepage            = "https://github.com/jey-song/model"
  s.license             = 'MIT'
  s.authors             = { "jey song" => "song.arain@gmail.com" }
  s.source              = { :git => "https://github.com/jey-song/model.git", :tag => s.version.to_s }
  s.source_files        = 'JSModel.*'
  s.requires_arc        = true
end
