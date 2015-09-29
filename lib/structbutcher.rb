require 'json'
require 'yaml'
require 'java-properties'
require 'hocon'

#vyndavator, zastamdator
#amputovat, implantovat
#amputate, implantate

class StructButcher
end

class StructButcher::Parser
    def load_struct(filename, format)
        case format
        when "json"
            return load_json(filename)
        when "yaml"
            return load_yaml(filename)
        when "properties"
            return load_properties(filename)
        when "hocon"
            return load_hocon(filename)
        end
    end

    def load_json(filename)
        file = File.read(filename)
        return JSON.parse(file)
    end

    def load_yaml(filename)
        return YAML.load_file(filename)
    end

    def load_properties(filename)
        hash = JavaProperties.load(filename)
        return Hash[hash.map{|(k,v)| [k.to_s,v]}]
    end

    def load_hocon(filename)
        conf = Hocon::ConfigFactory.parse_file(filename)
        return conf.root.unwrapped
    end
end


