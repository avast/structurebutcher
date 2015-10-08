require 'minitest/autorun'
require 'structurebutcher'
require 'yaml'
require 'java-properties'

class ParseTest < Minitest::Test
    def test_amputate_file
        butcher = StructureButcher.new
        body = { "one" => { "two" => { "three" => { "hash" =>
            {"one"=>1, "two"=>2, "three"=>3 }
        }}}}
        File.write("body.yaml", body.to_yaml)

        butcher.amputate_file(
            "body.yaml", "one.two.three.hash", "part.properties", "properties"
        )
        # butcher.amputate_file(
        #     "body.yaml", "one.two.three.hash", "part.hocon", "hocon"
        # )

        loaded = JavaProperties.load("part.properties")

        assert_equal(loaded[:three], "3")

        File.delete("part.properties")
        File.delete("body.yaml")
    end
end

