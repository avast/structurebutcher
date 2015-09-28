require 'minitest/autorun'
require 'structbutcher'

class ParseTest < Minitest::Test
    def test_json
        parser = StructButcher::Parser.new
        loaded = parser.load_json('test/test.json')
        assert_equal(loaded[0], 'test')
    end
    def test_yaml
        parser = StructButcher::Parser.new
        loaded = parser.load_yaml('test/test.yaml')
        assert_equal(loaded[0], 'test')
    end
    def test_properties
        parser = StructButcher::Parser.new
        loaded = parser.load_properties('test/test.properties')
        assert_equal(loaded[:key], 'test')
    end
    def test_hocon
        parser = StructButcher::Parser.new
        loaded = parser.load_hocon('test/test.hocon')
        assert_equal(loaded["test"][0], 'test')
    end
end


