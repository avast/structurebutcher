require 'minitest/autorun'
require 'structurebutcher'

class ParseTest < Minitest::Test
    def test_json
        parser = StructureButcher::Parser.new
        loaded = parser.load_json('test/test.json')
        assert_equal(loaded['key'][0], 'test')
    end
    def test_yaml
        parser = StructureButcher::Parser.new
        loaded = parser.load_yaml('test/test.yaml')
        assert_equal(loaded['key'][0], 'test')
    end
    def test_properties
        parser = StructureButcher::Parser.new
        loaded = parser.load_properties('test/test.properties')
        assert_equal(loaded['key'], 'test')
    end
    def test_hocon
        parser = StructureButcher::Parser.new
        loaded = parser.load_hocon('test/test.hocon')
        assert_equal(loaded['test'][0], 'test')
    end
end
