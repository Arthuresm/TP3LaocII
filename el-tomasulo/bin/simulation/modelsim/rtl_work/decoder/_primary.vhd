library verilog;
use verilog.vl_types.all;
entity decoder is
    port(
        CLK             : in     vl_logic;
        CLR             : in     vl_logic;
        ID              : in     vl_logic_vector(3 downto 0);
        confirma        : out    vl_logic_vector(7 downto 0)
    );
end decoder;
