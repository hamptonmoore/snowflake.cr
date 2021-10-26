require "time"

class Snowflake
    @time_bits : Int64
    @instance_bits : Int64
    @sequence_bits : Int64
    @sequence_max : Int64
    @newepoch : Int64
    def initialize(@instance : Int64, ep : Int64)
        @time_bits = 41_i64
        @instance_bits = 10_i64
        if @instance >= 2_i64**@instance_bits
            raise "Snowflake instance exceeds max value of #{2_i64 ** @instance_bits}"
        end
        @sequence_bits = 12_i64
        @sequence_max  = 2_i64**@sequence_bits
        @newepoch = ep
        @sequence = 0
    end

    def initialize(@instance : Int64, ep : Time)
        initialize(@instance, ep.to_unix_ms)
    end
    
    def next
        snowflake_id = 0_i64
        timebits = Time.utc.to_unix_ms - @newepoch
        @sequence+=1
        if @sequence >= @sequence_max
        @sequence = 0
        sleep 0.001
        end
        snowflake_id |= timebits << (@sequence_bits + @instance_bits)
        snowflake_id |= @instance << @sequence_bits
        snowflake_id |= @sequence
        snowflake_id
    end

    def set_epoch(ep : Time)
        @newepoch = ep.to_unix_ms
    end

    def set_epoch(ep : Int64)
        @newepoch = ep
    end
end