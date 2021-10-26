require "../src/snowflake.cr"

test = Snowflake.new 1023, Time.utc(2018, 1, 1, 0, 0, 0)
puts test.next
puts test.next