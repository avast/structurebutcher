require 'minitest/autorun'
require 'structurebutcher'

class ParseTest < Minitest::Test
    def test_amputate
        butcher = StructureButcher.new
        body = { "head" => 1, "trunk" => { "arms" => 2, "legs" => 2 } }
        part = butcher.amputate(body, "trunk.arms")
        assert_equal(part, 2)
    end

    def test_implantate
        butcher = StructureButcher.new
        body = { "head" => 1, "trunk" => { "arms" => 2, "legs" => 2 } }
        butcher.implantate(body, "trunk.arms", 3)
        assert_equal(body["trunk"]["arms"], 3)
    end

    def test_implantate_new_path
        butcher = StructureButcher.new
        body = { "head" => 1, "trunk" => {} }
        butcher.implantate(body, "trunk.arms", 3)
        assert_equal(body["trunk"]["arms"], 3)
    end
end

