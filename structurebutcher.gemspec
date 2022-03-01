Gem::Specification.new do |s|
    s.name = 'structurebutcher'
    s.homepage = 'https://github.com/avast/structurebutcher'
    s.version = '1.0.0'
    s.add_runtime_dependency 'json', ['~> 2.1']
    s.add_runtime_dependency 'hocon', ['~> 1.1']
    s.add_runtime_dependency 'java-properties', ['~> 0.1']
    s.date = '2022-03-01'
    s.summary = 'Config saver/restorer'
    s.description = 'Read a config file and write it to a YAML file under specific key'
    s.authors = 'Miroslav Tynovsky'
    s.email = 'tynovsky@avast.com'
    s.files = ['lib/structurebutcher.rb']
    s.license = 'MIT'
end
