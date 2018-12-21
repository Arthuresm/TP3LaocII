library verilog;
use verilog.vl_types.all;
entity CDBArbt is
    port(
        CLK             : in     vl_logic;
        CLK1            : in     vl_logic;
        CLK2            : in     vl_logic;
        CLR             : in     vl_logic;
        controle        : in     vl_logic;
        resultadoAddSub : in     vl_logic_vector(22 downto 0);
        resultadoLoadStore: in     vl_logic_vector(22 downto 0);
        clk_instAS      : in     vl_logic_vector(9 downto 0);
        clk_instLS      : in     vl_logic_vector(9 downto 0);
        CDB             : out    vl_logic_vector(19 downto 0);
        wren_banco      : out    vl_logic;
        RD              : out    vl_logic_vector(2 downto 0)
    );
end CDBArbt;
