Gem::Specification.new do |s|
    s.name = 'structurebutcher'
    s.homepage = 'https://github.com/avast/structurebutcher'
    s.version = '0.8.1'
    s.add_runtime_dependency 'json', ['~> 1']
    s.add_runtime_dependency 'hocon', ['~> 0.9.3']
    s.add_runtime_dependency 'java-properties', ['~> 0.0.2']
    s.date = '2015-12-10'
    s.summary = 'Config saver/restorer'
    s.description = 'Read a config file and write it to a YAML file under specific key'
    s.authors = 'Miroslav Tynovsky'
    s.email = 'tynovsky@avast.com'
    s.files = ['lib/structurebutcher.rb']
    s.license = 'MIT'
end
