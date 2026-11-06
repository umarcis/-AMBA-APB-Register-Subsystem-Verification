module apb_slave #(parameter DELAY_CYCLES = 1  // Default value, can be overridden in tb_top
) (
  input  logic        PCLK   ,
  input  logic        PRESETn,
  input  logic [31:0] PADDR  ,
  input  logic        PSEL   ,
  input  logic        PENABLE,
  input  logic        PWRITE ,
  input  logic [31:0] PWDATA ,
  output logic        PREADY ,
  output logic        PSLVERR,
  output logic [31:0] PRDATA
);

  logic [3:0] wait_states;  // Counter for delay cycles

  // Wait states counter logic
  always_ff @(posedge PCLK) begin
    if (!PRESETn) begin
      wait_states <= 0;  
    end else if (!PENABLE) begin
      wait_states <= 0;  // Reset wait states if PENABLE is low
    end else if (PENABLE && wait_states < DELAY_CYCLES) begin
      wait_states <= wait_states + 1;  // Increment counter during wait cycles
    end
  end

  // PREADY signal generation
  always_comb begin
    if (PRESETn) begin
      PREADY = 0;  
    end else if (DELAY_CYCLES == 0) begin
      PREADY = PENABLE;  // No delay, assert PREADY immediately when PENABLE is high
    end else begin
      PREADY = (PENABLE && (wait_states == DELAY_CYCLES));  // Assert PREADY after DELAY_CYCLES
    end
  end

  // Slave error logic
  always_comb begin
    if (PSEL && PENABLE && PREADY) begin
      if (PADDR == 3 || PADDR == 7 || PADDR == 9)
        PSLVERR = 1;
      else
        PSLVERR = 0;
    end else begin
      PSLVERR = 0;
    end
  end

endmodule



