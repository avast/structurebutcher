require 'minitest/autorun'
require 'structurebutcher'

class ParseTest < Minitest::Test
    def test_json
        parser = StructureButcher::Parser.new
        loaded = parser.load_json('test/test.json')
        assert_equal(loaded['key'][0], 'test')
    end
    def test_json_invalid
        parser = StructureButcher::Parser.new
        filename = 'test/test_invalid.json'
        assert_raises(Exception){ loaded = parser.load_json(filename) }
    end
    def test_yaml
        parser = StructureButcher::Parser.new
        loaded = parser.load_yaml('test/test.yaml')
        assert_equal(loaded['key'][0], 'test')
    end
    def test_yaml_invalid
        parser = StructureButcher::Parser.new
        filename = 'test/test_invalid.yaml'
        assert_raises(Exception){ loaded = parser.load_yaml(filename) }
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
    def test_hocon_invalid
        parser = StructureButcher::Parser.new
        filename = 'test/test_invalid.hocon'
        assert_raises(Exception){ loaded = parser.load_hocon(filename) }
    end
    def test_base64
        parser = StructureButcher::Parser.new
        loaded = parser.load_base64('test/test.xml')
        assert_equal(loaded, "PGtleT52YWx1ZTwva2V5Pgo=\n")
    end
end
