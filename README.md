# 19-bit-cpu-dv
Design and verification of a 19-bit CPU architecture in SystemVerilog.

!["Block diagram"](block_diagram.png)

The 19-bit CPU has 19-bit instructions and a 19-bit word. 20-bit addresses allow for 1 MB memory. 
This project was taken up as a challenge and refresher for CPU architecture concepts beyond the standard power-of-two memory and compute architectures.

## Design
The CPU is designed for a Harvard architecture with separate instruction and data memories. 
Signals are separated into three buses - control, data, and address.
Since using standard 8-bit-byte- and 16-bit-word-addressable memories would waste space for 19-bit words, the memories modeled are 19-bit-word addressable.

## Verification
