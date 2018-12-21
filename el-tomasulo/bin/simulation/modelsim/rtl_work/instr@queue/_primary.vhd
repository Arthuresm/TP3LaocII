library verilog;
use verilog.vl_types.all;
entity instrQueue is
    port(
        CLK             : in     vl_logic;
        CLR             : in     vl_logic;
        cheio           : out    vl_logic;
        vazio           : out    vl_logic;
        adc             : in     vl_logic;
        rtr             : in     vl_logic;
        instrIn         : in     vl_logic_vector(15 downto 0);
        instrOut        : out    vl_logic_vector(15 downto 0)
    );
end instrQueue;
