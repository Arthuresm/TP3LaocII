library verilog;
use verilog.vl_types.all;
entity instrRegister is
    port(
        CLK             : in     vl_logic;
        CLR             : in     vl_logic;
        IRin            : in     vl_logic;
        instrIn         : in     vl_logic_vector(15 downto 0);
        instrOut        : out    vl_logic_vector(15 downto 0)
    );
end instrRegister;
