library verilog;
use verilog.vl_types.all;
entity ASRS is
    port(
        ID_in           : in     vl_logic_vector(3 downto 0);
        CLK             : in     vl_logic;
        CLR             : in     vl_logic;
        start           : in     vl_logic;
        busy            : out    vl_logic;
        clockInstr      : out    vl_logic_vector(9 downto 0);
        Valor1          : out    vl_logic_vector(15 downto 0);
        Valor2          : out    vl_logic_vector(15 downto 0);
        OP_Rd           : out    vl_logic_vector(5 downto 0);
        despacho        : out    vl_logic;
        ID_out          : out    vl_logic_vector(3 downto 0);
        confirma        : in     vl_logic;
        CDB             : in     vl_logic_vector(19 downto 0);
        CLK_instr       : in     vl_logic_vector(9 downto 0);
        IRout           : in     vl_logic_vector(15 downto 0);
        depR0           : in     vl_logic_vector(2 downto 0);
        dataR0          : in     vl_logic_vector(15 downto 0);
        depR1           : in     vl_logic_vector(2 downto 0);
        dataR1          : in     vl_logic_vector(15 downto 0)
    );
end ASRS;
