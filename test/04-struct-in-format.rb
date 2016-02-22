require 'minitest/autorun'
require 'structurebutcher'
require 'yaml'
require 'java-properties'

class StructInFormatTest < Minitest::Test
    def test_struct_in_json
        storer = StructureButcher::Storer.new
        body = {
            "one" => [ "two", "three" ]
        }
        generated_json = storer.structure_in_format(body, "json")
        expected_json = '{"one":["two","three"]}'

        assert_equal(generated_json, expected_json)
    end

    def test_struct_in_hocon
        storer = StructureButcher::Storer.new
        body = {
            "one" => [ "two", "three" ]
        }
        generated_hocon = storer.structure_in_format(body, "hocon")
        expected_hocon = "one=[\n    two,\n    three\n]\n"

        assert_equal(generated_hocon, expected_hocon)
    end
end

