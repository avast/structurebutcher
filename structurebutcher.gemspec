Gem::Specification.new do |s|
    s.name = 'structurebutcher'
    s.version = '0.1.0'
    s.add_runtime_dependency 'hocon', ['~> 0.9.3']
    s.add_runtime_dependency 'java-properties', ['~> 0.0.2']
    s.date = '2015-09-24'
    s.summary = 'Config saver/restorer'
    s.description = 'Take config and put it to YAML under specific key'
    s.authors = 'Miroslav Tynovsky'
    s.email = 'tynovsky@avast.com'
    s.files = ['lib/structurebutcher.rb']
    s.license = 'MIT'
end
