import uvm_pkg::*;
import my_pkg::*;
import expanded_regfile_pkg::*;
`include "uvm_macros.svh"


module tb_top ();


  // Declare the value for DELAY_CYCLES
  parameter DELAY_CYCLES_VAL = 0;

  apb3_intf vif ();


  // Instantiate the APB Register File Wrapper
  apb_regfile_wrapper #(.DELAY_CYCLES(DELAY_CYCLES_VAL)) dut (
    .PCLK   (vif.PCLK   ),
    .PRESETn(vif.PRESETn),
    .PADDR  (vif.PADDR  ),
    .PSEL   (vif.PSEL   ),
    .PENABLE(vif.PENABLE),
    .PWRITE (vif.PWRITE ),
    .PWDATA (vif.PWDATA ),
    .PREADY (vif.PREADY ),
    .PSLVERR(vif.PSLVERR),
    .PRDATA (vif.PRDATA )
  );


  // Clock generation
  initial begin
    vif.PCLK = 0;
    forever #5 vif.PCLK = ~vif.PCLK;
  end


  // Reset generation
  initial begin
    vif.PRESETn = 0;  // Assert reset low
    repeat (6) @(posedge vif.PCLK);
    vif.PRESETn = 1;  // Deassert reset
  end



  // SCENARIO control based on plusargs
  initial begin
    // SCENARIO 1: PREADY is always low (timeout SCENARIO)
    if ($test$plusargs("FORCE_PREADY_DOWN")) begin
      force dut.PREADY = 0;
    end
    // SCENARIO 2: PREADY is always high
    else if ($test$plusargs("FORCE_PREADY_HIGH")) begin
      force dut.PREADY = 1;
    end
    // SCENARIO 3: PREADY asserted after a delay
    else if ($test$plusargs("RELEASE_PREADY_AFTER_DELAY")) begin
      force dut.PREADY = 0;
      repeat (30) @(posedge vif.PCLK);
      release dut.PREADY;
    end
    // SCENARIO 4: PREADY toggles during the transaction
    else if ($test$plusargs("TOGGLE_PREADY")) begin
      force dut.PREADY = 0;
      repeat (14) @(posedge vif.PCLK);
      force dut.PREADY = 1;
      repeat (3) @(posedge vif.PCLK);
      force dut.PREADY = 0;
      repeat (4) @(posedge vif.PCLK);
      release dut.PREADY;
    end
    // SCENARIO 5: PRESETn asserted for some clock cycles and de-asserted
    else if ($test$plusargs("RESET_TOGGLE")) begin
      repeat (16) @(posedge vif.PCLK);
      vif.PRESETn = 0;
      repeat (10) @(posedge vif.PCLK);
      vif.PRESETn = 1;
    end
    else begin
      $display("No valid SCENARIO found in plusargs.");
    end
  end

  initial begin
    uvm_config_db#(virtual apb3_intf )::set(uvm_root::get(),"", "vif",vif);  // setting the interface in database
  end

  // Instantiate the UVM environment
  initial begin
    run_test();
  end

initial begin
  $vcdplusfile("waves.vpd");
  $vcdpluson(0, tb_top);
end


endmodule



