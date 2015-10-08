require 'minitest/autorun'
require 'structurebutcher'
require 'yaml'
require 'java-properties'

class StructInFormatTest < Minitest::Test
    def test_struct_in_format
        storer = StructureButcher::Storer.new
        body = {
            "one" => [ "two", "three" ]
        }
        generated_json = storer.structure_in_format(body, "json")
        expected_json = '{"one":["two","three"]}'

        assert_equal(generated_json, expected_json)
    end
end

