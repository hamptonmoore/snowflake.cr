require "../src/snowflake.cr"
require "spec"

describe Snowflake do
    describe "generation" do
        it "Generate correct snowflake for January 13th 2029 at 1538" do
            snow = Snowflake.new 1, Time.utc(2015, 1, 1, 0, 0, 0)
            snow.generate(Time.utc(2029, 1, 13, 15, 38, 0), 0).should eq 1857836254494724096
        end
        it "Increasing sequence by n should increase ID by n" do
            snow = Snowflake.new 1, Time.utc(2015, 1, 1, 0, 0, 0)
            (snow.generate(Time.utc(2029, 1, 13, 15, 38, 0), 37)-snow.generate(Time.utc(2029, 1, 13, 15, 38, 0), 0)).should eq 37
            (snow.generate(Time.utc(2012, 1, 13, 15, 0, 0), 50)-snow.generate(Time.utc(2012, 1, 13, 15, 0, 0), 30)).should eq 20    
        end
    end

    describe "extraction" do
        it "Extract instance" do
            snow = Snowflake.new 1, Time.utc(2015, 1, 1, 0, 0, 0)
            snow.snowflake_to_instance(snow.generate(Time.utc(2029, 1, 13, 15, 38, 0), 0)).should eq 1 
            snow = Snowflake.new 5, Time.utc(2015, 1, 1, 0, 0, 0)
            snow.snowflake_to_instance(snow.generate(Time.utc(2017, 9, 12, 9, 12, 5), 5)).should eq 5
        end
    end
end
