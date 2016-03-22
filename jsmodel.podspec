Pod::Spec.new do |s|
    s.name = "JSModel"
    s.version = "0.1.0"
    s.summary = "JSModel is base model <json string <-> model>. Use key-value coding"
    s.homepage = "https://github.com/jey-song/model"
    s.license = 'MIT'
    s.author = { "jey song" => "song.arain@gmail.com" }
    s.platform = :ios, '7.0'
    s.source = { :git => "https://github.com/jey-song/model.git", :tag => "v0.1.0" }
    s.source_files = 'model.*'
    s.requires_arc = true
end