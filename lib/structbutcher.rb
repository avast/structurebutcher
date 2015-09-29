require 'json'
require 'yaml'
require 'java-properties'
require 'hocon'

#vyndavator, zastamdator
#amputovat, implantovat
#amputate, implantate

class StructButcher
    def amputate(body, slot)
        keys = slot.split('.')
        result = body
        while (key = keys.shift)
            result = result[key]
        end
        return result
    end

    def implantate(body, slot, part)
        keys = slot.split('.')
        last_key = keys.pop
        area = body
        while (key = keys.shift)
            area = area[key]
        end
        area[last_key] = part
    end

    def amputate_file(body_file, slot, part_file, format)
        parser = StructButcher::Parser.new
        body   = parser.load_struct(body_file, "yaml")

        butcher = StructButcher.new
        part = butcher.amputate(body, slot)

        storer = StructButcher::Storer.new
        storer.save_struct(part, out_file, format)
    end

    def implantate_file(body_file, slot, part_file, format)
        parser = StructButcher::Parser.new
        body   = parser.load_struct(body_file, "yaml")
        part   = parser.load_struct(part_file, format)

        butcher = StructButcher.new
        part = butcher.implantate(body, slot, part)

        storer = StructButcher::Storer.new
        storer.save_struct(body, body_file, "yaml")
    end
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
        else
            throw "Not implemented"
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

class StructButcher::Storer
    def save_struct(struct, filename, format)
        case format
        when "json"
            File.write(filename, JSON.generate(struct))
        when "yaml"
            File.write(filename, struct.to_yaml)
        when "properties"
            JavaProperties.write(struct, filename)
        else
            throw "Not implemented"
        end
    end
end
