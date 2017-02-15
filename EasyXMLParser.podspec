Pod::Spec.new do |s|
s.name         = "EasyXMLParser"
s.version      = "1.1.0"
s.summary      = "EasyXMLParser is a simple and easy to use xml parser written in swift for iOs"
s.homepage     = "https://github.com/Asifadam93/EasyXMLParser"
s.license      = { :type => "BSD", :file => "LICENSE" }
s.author       = { "ESGI" => "contact@esgi.fr" }
s.source       = { :git => "https://github.com/Asifadam93/EasyXMLParser.git", :tag => "v#{s.version}" }
s.source_files = 'EasyXMLParser/*.{swift,h}'
s.ios.deployment_target = '8.0'
s.requires_arc = true
end
