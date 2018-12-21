library verilog;
use verilog.vl_types.all;
entity programCounter is
    port(
        CLK             : in     vl_logic;
        CLR             : in     vl_logic;
        incr            : in     vl_logic;
        addrOut         : out    vl_logic_vector(4 downto 0)
    );
end programCounter;
