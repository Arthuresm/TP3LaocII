library verilog;
use verilog.vl_types.all;
entity registerFile is
    port(
        CLK             : in     vl_logic;
        CLR             : in     vl_logic;
        wren            : in     vl_logic;
        numW            : in     vl_logic_vector(2 downto 0);
        depW            : in     vl_logic_vector(3 downto 0);
        wdep            : in     vl_logic;
        depID           : in     vl_logic_vector(2 downto 0);
        dadoDep         : in     vl_logic_vector(3 downto 0);
        dataW           : in     vl_logic_vector(15 downto 0);
        numR0           : in     vl_logic_vector(2 downto 0);
        depR0           : out    vl_logic_vector(3 downto 0);
        dataR0          : out    vl_logic_vector(15 downto 0);
        numR1           : in     vl_logic_vector(2 downto 0);
        depR1           : out    vl_logic_vector(3 downto 0);
        dataR1          : out    vl_logic_vector(15 downto 0)
    );
end registerFile;
