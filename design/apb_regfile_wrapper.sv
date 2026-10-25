module apb_regfile_wrapper #(parameter DELAY_CYCLES = 1) (
  input  logic        PCLK,
  input  logic        PRESETn,
  input  logic [31:0] PADDR,
  input  logic        PSEL,
  input  logic        PENABLE,
  input  logic        PWRITE,
  input  logic [31:0] PWDATA,
  output logic        PREADY,
  output logic        PSLVERR,
  output logic [31:0] PRDATA
);

  logic [31:0] s_regfile_wr_data;
  logic s_cpuif_rd_ack, s_cpuif_rd_err;
  logic s_cpuif_wr_ack, s_cpuif_wr_err;
  logic apb_pslverr;

  expanded_regfile_pkg::expanded_regfile__in_t  hwif_in;
  expanded_regfile_pkg::expanded_regfile__out_t hwif_out;

  logic [4:0] counter;
  logic [4:0] counter_delay;
  logic       start_increment;
  logic       interrupt_data_we;
  logic [7:0] interrupt_data_next;

  // Preserve the existing testbench's ACTIVE-HIGH reset convention,
  // despite the PRESETn signal name. APB timing is unchanged in this fix.
  apb_slave #(.DELAY_CYCLES(DELAY_CYCLES)) apb_slave_inst (
    .PCLK    (PCLK),
    .PRESETn (PRESETn),
    .PADDR   (PADDR),
    .PSEL    (PSEL),
    .PENABLE (PENABLE),
    .PWRITE  (PWRITE),
    .PWDATA  (PWDATA),
    .PREADY  (PREADY),
    .PSLVERR (apb_pslverr),
    .PRDATA  ()
  );

  expanded_regfile expanded_regfile_inst (
    .clk                  (PCLK),
    .rst                  (PRESETn),
    .s_cpuif_req          (PSEL && PENABLE),
    .s_cpuif_req_is_wr    (PWRITE),
    // Explicit slice preserves the original six-bit address truncation.
    .s_cpuif_addr         (PADDR[5:0]),
    .s_cpuif_wr_data      (s_regfile_wr_data),
    .s_cpuif_wr_biten     (32'hFFFFFFFF),
    .s_cpuif_req_stall_wr (),
    .s_cpuif_req_stall_rd (),
    .s_cpuif_rd_ack       (s_cpuif_rd_ack),
    .s_cpuif_rd_err       (s_cpuif_rd_err),
    .s_cpuif_rd_data      (PRDATA),
    .s_cpuif_wr_ack       (s_cpuif_wr_ack),
    .s_cpuif_wr_err       (s_cpuif_wr_err),
    .hwif_out             (hwif_out),
    .hwif_in              (hwif_in)
  );

  always_ff @(posedge PCLK) begin
    if (PRESETn)
      counter <= 5'd0;
    else if (counter < 5'd31)
      counter <= counter + 5'd1;
    else
      counter <= 5'd0;
  end

  // Store interrupt hardware-update state in separate registers.
  // Reset is the only initializer, and it has priority over incrementing.
  always_ff @(posedge PCLK) begin
    if (PRESETn) begin
      counter_delay      <= 5'd0;
      start_increment    <= 1'b0;
      interrupt_data_we  <= 1'b0;
      interrupt_data_next <= 8'd0;
    end else begin
      if (hwif_out.interrupt_control.data.value >= 8'd5)
        counter_delay <= counter_delay + 5'd1;

      if (counter_delay > 5'd10)
        start_increment <= 1'b1;

      if (start_increment) begin
        interrupt_data_we   <= 1'b1;
        interrupt_data_next <=
            hwif_out.interrupt_control.data.value + 8'd1;
      end
    end
  end

  // One process drives the entire input structure. Tie unused hardware
  // inputs low, including write enables and increment controls.
  // Use with the accompanying package without member initializers.
  always_comb begin
    hwif_in = '{default: '0};
    hwif_in.init_control_status.status.next = counter[3:0];
    hwif_in.fifostatus.empty.next = (counter < 5'd8);
    hwif_in.fifostatus.full.next  = (counter > 5'd8);
    hwif_in.interrupt_control.data.we   = interrupt_data_we;
    hwif_in.interrupt_control.data.next = interrupt_data_next;
  end

  assign s_regfile_wr_data =
      (PSEL && PENABLE && PREADY && PWRITE) ? PWDATA : 32'd0;

  // One driver combines both existing sources of slave errors.
  assign PSLVERR = apb_pslverr | s_cpuif_wr_err | s_cpuif_rd_err;

endmodule
