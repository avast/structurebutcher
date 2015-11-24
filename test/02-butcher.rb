require 'minitest/autorun'
require 'structurebutcher'

class ParseTest < Minitest::Test
    def test_split_escape
        butcher = StructureButcher.new
        string = "trunk.ar\\.ms"
        assert_equal(["trunk", "ar.ms"], butcher.split_escape(string))
    end

    def test_amputate
        butcher = StructureButcher.new
        body = { "head" => 1, "trunk" => { "arms" => 2, "legs" => 2 } }
        part = butcher.amputate(body, "trunk.arms")
        assert_equal(part, 2)
    end

    def test_implantate
        butcher = StructureButcher.new
        body = { "head" => 1, "trunk" => { "ar.ms" => 2, "legs" => 2 } }
        butcher.implantate(body, "trunk.ar\\.ms", 3)
        assert_equal(3, body["trunk"]["ar.ms"])
    end

    def test_implantate_new_path
        butcher = StructureButcher.new
        body = { "head" => 1, "trunk" => {} }
        butcher.implantate(body, "trunk.arms", 3)
        assert_equal(body["trunk"]["arms"], 3)
    end
end

