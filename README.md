# AMBA APB Register Subsystem Verification

**SystemRDL · PeakRDL · SystemVerilog · UVM RAL · QuestaSim · Synopsys VCS**

This repository contains my graduate project on developing and verifying an AMBA APB register subsystem using SystemRDL and the UVM Register Abstraction Layer (RAL). I used PeakRDL to generate register RTL, a UVM register model, and HTML documentation, then connected the generated register block to a custom APB wrapper and UVM verification environment.

The project follows the complete register-access path: a register sequence requests an operation, an adapter converts it into a bus transaction, and an APB driver accesses the DUT. A monitor observes bus activity and sends transactions to a predictor and scoreboard.

**Author:** Muhammad Umar  
**Program:** Master of Science in Computer Engineering, California State University, Northridge

## Project scope

- A generated register block containing 16 registers and 51 fields in the checked-in RTL and RAL model.
- A 32-bit APB data interface and a 64-byte local register map.
- Software access policies including RW, RO, read-clear, write-one-to-clear, and write-zero-to-clear.
- Hardware-driven status fields, counter behavior, and controlled hardware updates.
- A UVM environment with a register sequence, adapter, sequencer, driver, monitor, predictor, and scoreboard.
- Investigation of transfers with and without inserted wait states, readiness timeout handling, and reset during register traffic.
- Development waveform analysis in QuestaSim and command-line scenario runs in Synopsys VCS.


## Architecture

![UVM register verification architecture](<Supporting_Documents/ABP_Env_UVM.drawio(1).png>)

The register model holds the address map, field properties, desired values, and mirrored values. The adapter's `reg2bus()` method creates the bus item for a RAL access, while `bus2reg()` converts returned or observed transaction information into register-operation information.

The monitor publishes observed transactions to `uvm_reg_predictor` to maintain the register mirror. The scoreboard performs selected field comparisons. The mirror represents the model's view of the hardware; it is not the physical register storage.

The custom wrapper connects APB signals to the generated register block's passthrough CPU interface. It also supplies demonstration hardware updates to selected fields.

## Repository contents

| Location | Contents |
|---|---|
| [`SystemRDL/`](SystemRDL/) | Register description source |
| [`design/`](design/) | Generated register RTL and package, custom APB wrapper, and slave response logic |
| [`verification/register_model/`](verification/register_model/) | Generated UVM register model |
| [`verification/`](verification/) | UVM components, interface, sequence, test, and testbench top |
| [`verification/sim/`](verification/sim/) | VCS run script, compilation file list, and QuestaSim waveform configuration |
| [`documentation_html/`](documentation_html/) | Generated HTML register documentation |
| [`Supporting_Documents/`](Supporting_Documents/) | Architecture drawing, protocol specifications, environment notes, and five scenario logs |
| [`Introduction to SystemRDL(Presentation).pptx`](<Introduction to SystemRDL(Presentation).pptx>) | Project presentation and development waveforms |

## Register map

The checked-in RTL and UVM model contain 32-bit registers at four-byte offsets:

| Offset | Register |
|---|---|
| `0x00` | `init_control_status` |
| `0x04` | `mode_control_status` |
| `0x08` | `interrupt_control` |
| `0x0C` | `power_control_status` |
| `0x10` | `reset_control_status` |
| `0x14` | `transmit_control_status` |
| `0x18` | `csr_reg` |
| `0x1C` | `conf_reg` |
| `0x20` | `sys_stat_reg` |
| `0x24` | `int_reg` |
| `0x28` | `cntrl_reg` |
| `0x2C` | `perf_reg` |
| `0x30` | `pm_reg` |
| `0x34` | `dbg_reg` |
| `0x38` | `err_reg` |
| `0x3C` | `fifostatus` |

Most registers contain `control[3:0]`, `status[7:4]`, and `data[15:8]`. The power-control and FIFO-status registers have different field layouts. Refer to the generated model and HTML documentation for individual field definitions.

## Requirements

- A SystemVerilog simulator with UVM support and a valid license.
- Synopsys VCS with UVM 1.2 support for the supplied `run_vcs.sh` script.
- Bash for the simulation commands below.
- Python 3 and PeakRDL exporter packages if regenerating register outputs.

The recorded VCS scenario logs identify VCS `Y-2026.03-SP1_Full64` and UVM 1.2. QuestaSim was also used during development.

## Run with Synopsys VCS

Clone the repository and enter the simulation directory:

```bash
git clone https://github.com/umarcis/-AMBA-APB-Register-Subsystem-Verification.git apb-register-verification
cd apb-register-verification/verification/sim
```

Compile the design and run the default test:

```bash
bash run_vcs.sh
```

The script uses `file_list.f`, selects `tb_top`, and runs `reg_file_test`. It produces `compile.log`, `simulation.log`, and the `simv` executable. The testbench also records `waves.vpd` through VCS waveform system tasks.

With no scenario plusarg, the testbench prints `No valid SCENARIO found in plusargs.` and runs without a forced readiness or additional reset scenario.

### Select a scenario

After compilation, run the existing executable with one scenario plusarg:

```bash
./simv +UVM_TESTNAME=reg_file_test +UVM_VERBOSITY=UVM_NONE \
  +RELEASE_PREADY_AFTER_DELAY -l RELEASE_PREADY_AFTER_DELAY_simulation.log
```

To run all five scenarios separately:

```bash
for scenario in \
  FORCE_PREADY_DOWN \
  FORCE_PREADY_HIGH \
  RELEASE_PREADY_AFTER_DELAY \
  TOGGLE_PREADY \
  RESET_TOGGLE
do
  ./simv +UVM_TESTNAME=reg_file_test +UVM_VERBOSITY=UVM_NONE \
    +"$scenario" -l "${scenario}_simulation.log"
done
```

Use one scenario plusarg per run. The testbench selects scenarios through an `if`/`else if` chain. Each run overwrites `waves.vpd`, so copy or rename it before starting another run if you want to keep every waveform.

## Verification scenarios and recorded results

The five recorded logs are available in [`Supporting_Documents/`](Supporting_Documents/).

| Scenario | Stimulus | Recorded observation |
|---|---|---|
| `FORCE_PREADY_DOWN` | Holds `PREADY` low | Reports 101 unsuccessful access statuses and reaches the global phase timeout |
| `FORCE_PREADY_HIGH` | Holds `PREADY` high | Reaches the end with 115 successful statuses, but readbacks are zero despite nonzero writes |
| `RELEASE_PREADY_AFTER_DELAY` | Holds readiness low for 30 rising clock edges, then releases it | Reports two unsuccessful accesses followed by 113 successful statuses, including selected matching readbacks |
| `TOGGLE_PREADY` | Forces readiness low, high, and low before releasing it | Reaches the end with 115 successful statuses |
| `RESET_TOGGLE` | Applies an additional active-high reset pulse during sequence activity | Reaches the end with 115 successful statuses; selected reads show clearing of earlier register state |

These counts refer to sequence access-status messages, not independently counted APB transfers. A successful status alone does not establish data correctness. The forced-high case demonstrates why returned data and waveform timing must also be examined.

The project also investigates read-clear behavior by reading a register again after the first read, and exercises field writes through RAL `write()`/`read()` and `set()`/`update()` operations.

## Waveform inspection

Useful signals include `PCLK`, `PRESETn`, `PSEL`, `PENABLE`, `PREADY`, `PADDR`, `PWRITE`, `PWDATA`, `PRDATA`, and `PSLVERR`. Internal CPU-interface requests, acknowledgments, and register storage help relate a bus transfer to the field update.

For VCS recordings, open the VPD file in an available Synopsys waveform viewer, for example:

```bash
dve -vpd waves.vpd &
```

For QuestaSim, [`verification/sim/wave.do`](verification/sim/wave.do) adds the APB and internal register signals after loading `tb_top`. The current testbench contains VCS-specific `$vcdplusfile` and `$vcdpluson` calls; guard or disable those when using a QuestaSim setup that does not support them. Compile the files in `file_list.f` with your installation's UVM library configuration, load the test, then use:

```tcl
do wave.do
run -all
```

## Register generation

Install the generation tools in a Python virtual environment:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install peakrdl peakrdl-regblock peakrdl-uvm peakrdl-html
```

**Source configuration:** the checked-in RTL and RAL map above use a single `csr_reg` at `0x18`. The repository's SystemRDL source currently contains the array example `csr_reg [6] @0x100 += 0x10`. To regenerate the same 16-register configuration, use the scalar declaration `csr_reg @ 0x18` before exporting.

From the repository root, the following commands export to a separate directory:

```bash
mkdir -p generated
peakrdl regblock SystemRDL/expanded_regfile.rdl --cpuif passthrough \
  -o generated/register_block
peakrdl uvm SystemRDL/expanded_regfile.rdl \
  -o generated/register_model.sv
peakrdl html SystemRDL/expanded_regfile.rdl \
  -o generated/documentation_html
```

The passthrough interface is used because this project supplies its own APB wrapper. Review regenerated outputs against the wrapper and simulator integration before replacing the checked-in files.

## View the HTML documentation

To browse the checked-in documentation, start a local server from the repository root:

```bash
python3 -m http.server 8000 --directory documentation_html
```

Open <http://localhost:8000> to inspect register addresses, field positions, software access permissions, reset values, and descriptions.

## Implementation notes

- **Reset:** this project intentionally uses a synchronous active-high reset, although the signal is named `PRESETn`. This differs from the active-low reset convention in the APB specification.
- **Addressing:** the wrapper passes `PADDR[5:0]` to the generated block. Upper address bits are not separately decoded in the wrapper.
- **Wait states:** `DELAY_CYCLES_VAL` in `tb_top.sv` controls the normal readiness delay and is currently set to zero. Changing it requires recompilation; scenario plusargs independently force readiness or reset behavior.
- **Checking:** the scoreboard checks selected fields at four offsets, and mode-register mismatch reporting is disabled. The driver's access status checks readiness timeout handling but does not evaluate `PSLVERR`.
- **Readiness timing:** the current driver can assert and remove `PENABLE` in the same simulation timestep when `PREADY` is already high. The forced-high results should therefore be read as a timing investigation, rather than a functional-pass claim.

## Reference material

- [Arm AMBA APB specification](Supporting_Documents/APB_Spec.pdf)
- [Accellera SystemRDL 2.0 specification](Supporting_Documents/SystemRDL_2.0_Jan2018.pdf)
- [PeakRDL documentation](https://peakrdl.readthedocs.io/)
- [Accellera UVM resources](https://www.accellera.org/downloads/standards/uvm)
