% Initialization script for Microchip SAME70 based motor control
% examples.

% Copyright 2023 The MathWorks, Inc.

%% Detect MATLAB version
release = version('-release');
release = sscanf(release,'%d');

%% Set PWM Switching frequency
PWM_frequency 	= 20e3;             %Hz     // converter s/w freq
T_pwm           = 1/PWM_frequency;  %s      // PWM switching time period

%% Set Sample Times
Ts          	= T_pwm;        %sec        // simulation time step for controller
Ts_simulink     = T_pwm/2;      %sec        // simulation time step for model simulation
Ts_motor        = T_pwm/2;      %Sec        // Simulation sample time
Ts_inverter     = T_pwm/2;      %sec        // simulation time step for average value inverter
Ts_speed        = 2 * Ts;       %Sec        // Sample time for speed controller
Ts_SerialCom    = 0.0005;       %sec        // Sample time for serial communication
Ts_tuning       = 0.1;
%% Set data type for controller & code-gen
dataType = 'single';            % Floating point code-generation

%% System Parameters // Hardware parameters
% pmsm = mcb_SetPMSMMotorParameters('Teknic2310P');
pmsm.model  = 'Long_Hurst';     %           // Manufacturer Model Number
pmsm.sn     = '005';            %           // Manufacturer Model Number
pmsm.p      = 5;                %           // Pole Pairs for the motor
pmsm.Rs     = 0.565;            %Ohm        // Stator Resistor
pmsm.Ld     = 0.00032;          %H          // D-axis inductance value
pmsm.Lq     = 0.00032;          %H          // Q-axis inductance value
pmsm.J      = 7.061551833333e-5;%Kg-m2      // Inertia in SI units
pmsm.B      = 2.636875217824e-5;%Kg-m2/s    // Friction Co-efficient
pmsm.Ke     = 7.24;             %Bemf Const	// Vline_peak/krpm
pmsm.Kt     = 0.274;            %Nm/A       // Torque constant
pmsm.I_rated= 3.42*sqrt(2);     %A      	// Rated current (phase-peak)
pmsm.N_max  = 3644;             %rpm        // Max speed
pmsm.PositionOffset = 0.1712;	%PU position// Position Offset
pmsm.QEPSlits       = 250;      %           // QEP Encoder Slits
pmsm.FluxPM     = (pmsm.Ke)/(sqrt(3)*2*pi*1000*pmsm.p/60); %PM flux computed from Ke
pmsm.T_rated    = (3/2)*pmsm.p*pmsm.FluxPM*pmsm.I_rated;   %Get T_rated from I_rated
pmsm.N_rated = 2000;
pmsm.QEPIndexPresent = false;

%% Target hardware parameters
target.model                = 'ATSAME70Q21';% Manufacturer Model Number
target.CPU_frequency        = 300e6;    %(Hz)   // Clock frequency
target.PWM_frequency        = PWM_frequency;   %// PWM frequency
target.PWM_Counter_Period   = round(target.CPU_frequency/target.PWM_frequency/2); %(PWM timer counts)
target.ADCCalibEnable = 1;  % Enable : 1, Disable :0
target.MaxADCCnt      = 4095;     %Counts // ADC Counts Max Value
target.SerialFrameSize = 120;

%% Inverter Parameters
inverter.model          = 'Microchip_inverter';% Manufacturer Model Number
inverter.V_dc           = 24;       %V      // DC Link Voltage of the Inverter
inverter.I_rated = 4.4;

if(release<2021)
    inverter.I_max = 4.4;           %Amps   // Max current that can be measured by 3.3V ADC
    inverter.AmpPerCount = inverter.I_max/target.MaxADCCnt;
else
    inverter.ISenseMax = 4.4;       %Amps   // Max current that can be measured by 3.3V ADC
    inverter.AmpPerCount = inverter.ISenseMax/target.MaxADCCnt;
end
inverter.Rds_on         = 6.5e-3;   %Ohms   // Rds ON for BoostXL-DRV8301
inverter.Rshunt         = 0.025;    %Ohms   // Rshunt for BoostXL-DRV8301
inverter.ADCOffsetCalibEnable = 1;  % Enable: 1, Disable: 0
inverter.CtSensAOffset = 2048;
inverter.CtSensBOffset = 2048;
inverter.R_board        = inverter.Rds_on + inverter.Rshunt/3;  %Ohms
inverter.VoltPerCount = 0.01;

pmsm.N_base = mcb_getBaseSpeed(pmsm,inverter);
%% PU System details // Set base values for pu conversion
PU_System = mcb_SetPUSystem(pmsm,inverter);

%% Initial PI parameters
PI_params.Kp_Id = 0.5;
PI_params.Ki_Id = 400;
PI_params.Kp_Iq = 0.5;
PI_params.Ki_Iq = 400; 
PI_params.Kp_Speed = 0.25;
PI_params.Ki_Speed = 5; 

%% FOC Autotuner parameters
PI_params.CurrentBW         = 2000;     %rad/s      //Bandwidth for PI controller of current loops
PI_params.CurrentPhaseMargin= 80;       %degrees    //Phase margin for PI controller of current loops
PI_params.CurrentSineAmp    = 0.15;     %           //Amplitude for sinestream during current loop tuning experiment
PI_params.SpeedBW           = 50;       %rad/s      //Bandwidth for PI controller of speed loop
PI_params.SpeedPhaseMargin  = 30;       %degrees    //Phase margin for PI controller of speed loop
PI_params.SpeedSineAmp      = 0.05;     %           //Amplitude for sinestream during speed loop tuning experiment

PI_params.delay_Currents    = 1; %No of samples delayed for current sensing

clear release;