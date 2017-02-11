Pod::Spec.new do |s|
s.name         = "EasyXMLParser"
s.version      = "1.0.7"
s.summary      = "Parser un fichier XML et de renvoyer des objets ou des dictionnaires de données"
s.homepage     = "https://github.com/Asifadam93/EasyXMLParser"
s.license      = { :type => "BSD", :file => "LICENSE" }
s.author       = { "ESGI" => "contact@esgi.fr" }
s.source       = { :git => "https://github.com/Asifadam93/EasyXMLParser.git", :tag => "v#{s.version}" }
s.source_files = 'EasyXMLParser/*.{swift,h}'
s.ios.deployment_target = '8.0'
s.requires_arc = true
end
