require 'json'
require 'yaml'
require 'java-properties'
require 'hocon'
require 'hocon/parser/config_document_factory'
require 'hocon/config_value_factory'
require 'base64'

#vyndavator, zastamdator
#amputovat, implantovat
#amputate, implantate

class StructureButcher
    def split_escape(str)
        output = []
        str.scan(/(?>\\.|[^\\.])+/) do |chunk|
            output.push( chunk.gsub(/\\(.)/, '\1') )
        end
        return output
    end

    def amputate(body, slot)
        keys = split_escape(slot)
        result = body
        while (key = keys.shift)
            result = result[key]
        end
        return result
    end

    def implantate(body, slot, part)
        keys = split_escape(slot)
        last_key = keys.pop
        area = body

        if not area
            area = Hash.new
        end

        while (key = keys.shift)
            if not area.has_key?(key)
                then area[key] = {}
            end
            area = area[key]
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

        # make sure we work with hash
        # it does not make sense to work with anything else
	if not body.is_a?(Hash)
	    body = Hash.new
	end

        butcher = StructureButcher.new
        part = butcher.implantate(body, slot, part)

        storer = StructureButcher::Storer.new
        storer.save_structure(body, body_file, "yaml")
    end

    def implantate_struct_into_file(body_file, slot, part_struct)
        parser = StructureButcher::Parser.new
        body   = parser.load_structure(body_file, "yaml")

        # make sure we work with hash
        # it does not make sense to work with anything else
	if not body.is_a?(Hash)
	    body = Hash.new
	end

        butcher = StructureButcher.new
        butcher.implantate(body, slot, part_struct)

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
        when "javaprops"
            return load_properties(filename)
        when "hocon"
            return load_hocon(filename)
        when "base64"
            return load_base64(filename)
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

    def load_base64(filename)
        content = File.read(filename)
        return Base64.encode64(content)
    end
end

class StructureButcher::Storer
    def structure_in_format(structure, format)
        case format
        when "json"
            return JSON.generate(structure)
        when "yaml"
            return structure.to_yaml
        when "properties"
            return JavaProperties.generate(structure)
        when "hocon"
            return JSON.generate(structure) #FIXME
        else
            throw "Unsupported format"
        end
    end

    def save_structure(structure, filename, format)
        File.write(filename, structure_in_format(structure, format))
    end
end
