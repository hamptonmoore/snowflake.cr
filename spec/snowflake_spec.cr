require "../src/snowflake.cr"
require "spec"

describe Snowflake do
    describe "generation" do
        it "Generate correct snowflake for January 13th 2029 at 1538" do
            snow = Snowflake.new 1, Time.utc(2015, 1, 1, 0, 0, 0)
            snow.generate(Time.utc(2029, 1, 13, 15, 38, 0), 0).should eq 1857836254494724096
        end
        it "Increasing sequence by 37 should increase ID by 37" do
            snow = Snowflake.new 1, Time.utc(2015, 1, 1, 0, 0, 0)
            (snow.generate(Time.utc(2029, 1, 13, 15, 38, 0), 37)-snow.generate(Time.utc(2029, 1, 13, 15, 38, 0), 0)).should eq 37
        end
    end
end
