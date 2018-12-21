library verilog;
use verilog.vl_types.all;
entity UA_Address is
    port(
        CLK             : in     vl_logic;
        CLR             : in     vl_logic;
        start           : in     vl_logic;
        finalizado      : in     vl_logic;
        ID_RS_in        : in     vl_logic_vector(3 downto 0);
        Dado1           : in     vl_logic_vector(15 downto 0);
        Dado2           : in     vl_logic_vector(15 downto 0);
        Dado3           : in     vl_logic_vector(15 downto 0);
        OP_Rd           : in     vl_logic_vector(5 downto 0);
        Resultado       : out    vl_logic_vector(22 downto 0);
        confirmacao     : out    vl_logic;
        busy            : out    vl_logic;
        desWrAS         : out    vl_logic
    );
end UA_Address;
