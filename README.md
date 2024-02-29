# Demos for Motor Control Deployment on Microchip Controllers
Field-Oriented Control (FOC) of Permanent Magnet Synchronous Motor (PMSM) Using Microchip's dsPICDEM™ MCLV-2 Development Board 

These examples demonstrate parameter estimation, tuning of PI controller gains using the FOC Autotuner, and field-oriented control (FOC) of three-phase PMSM. The examples use the quadrature encoder for position sensing during the parameter estimation and FOC Autotuner. FOC uses flux observer and sliding mode observer position estimation techniques.

The motor control algorithm runs on the Microchip dsPICDEM™ MCLV-2 Development Board. This board provides a cost-effective solution for developing and evaluating 3-phase sensor-based or 3-phase sensorless Brushless DC (BLDC) and PMSM control applications. It supports Microchip’s 100-pin motor control Plug-In-Modules (PIMs) with these controllers:
- dsPIC33C, dsPIC33E and dsPIC33F Digital Signal Controllers (DSCs)
- PICM32MK and ATSAME70 families

The board supports the usage of internal on-chip op-amps found on certain dsPIC® and PIC32MK devices as well as external op-amps provided on the MCLV-2 board. For more details about the hardware, see [dsPICDEM™ MCLV-2 Development Board (DM330021-2).](https://www.microchip.com/en-us/development-tool/dm330021-2)

## Setup 

1. Download the repository and extract the contents.
2. For instructions to use these demos, see the enclosed pdf documents.


### [MathWorks®  Products](https://www.mathworks.com)

Requires MATLAB® release R2021b or newer
- [Simulink®](https://www.mathworks.com/products/simulink.html)
- [Motor Control Blockset™](https://www.mathworks.com/products/motor-control.html)
- [Embedded Coder®](https://www.mathworks.com/products/embedded-coder.html)
- [Stateflow®](https://www.mathworks.com/products/stateflow.html)
- [MATLAB® Coder™](https://www.mathworks.com/products/matlab-coder.html)
- [Simulink® Coder](https://www.mathworks.com/products/simulink-coder.html)

### 3rd Party Products

- [MPLAB® X IDE and IPE (v5.45 or later)](https://www.microchip.com/en-us/tools-resources/develop/mplab-x-ide)
- [MPLAB® XC compilers (v1.6 or later)](https://www.microchip.com/en-us/tools-resources/develop/mplab-xc-compilers)
- [MPLAB® Device Blocks for Simulink Toolbox](https://www.mathworks.com/matlabcentral/fileexchange/71892-mplab-device-blocks-for-simulink-dspic-pic32-and-sam-mcu)

## Getting Started 
For detailed instructions to use these demos, see the enclosed pdf documents.

A Mathworks-Microchip joint webinar is available [here.](https://www.mathworks.com/videos/motor-control-with-embedded-coder-for-microchip-mcus-1488570451176.html)

[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=mathworks/Motor-Control-Microchip)

## License
The license is available in the *License.txt* file in this GitHub repository.

## Community Support
[MATLAB Central](https://www.mathworks.com/matlabcentral)

Copyright 2022 The MathWorks, Inc.
