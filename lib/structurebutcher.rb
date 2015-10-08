require 'json'
require 'yaml'
require 'java-properties'
require 'hocon'
require 'hocon/parser/config_document_factory'
require 'hocon/config_value_factory'

#vyndavator, zastamdator
#amputovat, implantovat
#amputate, implantate

class StructureButcher
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
            area = area[key] #TODO: create hash if not exists
        end
        area[last_key] = part
    end

    def amputate_file(body_file, slot, part_file, format)
        parser = StructureButcher::Parser.new
        body   = parser.load_structure(body_file, "yaml")

        butcher = StructureButcher.new
        part = butcher.amputate(body, slot)

        storer = StructureButcher::Storer.new
        storer.save_structure(part, part_file, format)
    end

    def implantate_file(body_file, slot, part_file, format)
        parser = StructureButcher::Parser.new
        body   = parser.load_structure(body_file, "yaml")
        part   = parser.load_structure(part_file, format)

        butcher = StructureButcher.new
        part = butcher.implantate(body, slot, part)

        storer = StructureButcher::Storer.new
        storer.save_structure(body, body_file, "yaml")
    end
end

class StructureButcher::Parser
    def load_structure(filename, format)
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

    def recursive_stringify_keys(h)
        case h
        when Hash
            Hash[
                h.map do |k, v|
                    [ k.respond_to?(:to_s) ? k.to_s : k,
                      recursive_stringify_keys(v)
                    ]
                end
            ]
        when Enumerable
            h.map { |v| recursive_stringify_keys(v) }
        else
            h
        end
    end

    def load_json(filename)
        file = File.read(filename)
        return recursive_stringify_keys(JSON.parse(file))
    end

    def load_yaml(filename)
        return recursive_stringify_keys(YAML.load_file(filename))
    end

    def load_properties(filename)
        return recursive_stringify_keys(JavaProperties.load(filename))
    end

    def load_hocon(filename)
        return recursive_stringify_keys(Hocon.load(filename))
    end
end

class StructureButcher::Storer
    def save_structure(structure, filename, format)
        case format
        when "json"
            File.write(filename, JSON.generate(structure))
        when "yaml"
            File.write(filename, structure.to_yaml)
        when "properties"
            JavaProperties.write(structure, filename)
        else
            doc = Hocon::Parser::ConfigDocumentFactory.parse_string("{}")
            structure.each do |k, v|
                doc.set_value(k, v)
            end
            File.write(filename, doc.render)
        end
    end
end