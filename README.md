# Custom-processor-for-image-down-sampling
This repository contains a custom processor and an UART transceiver build using Verilog for the task of image downsampling

>>Prefer the report for more information

Required Software
>MATLAB

>Quartus

Hardware
>Altera DE2-115 development board
![DE2 board](images/DE2.PNG)

How to use

> Write the code using the instructions in the ISA

>Convert it to the machine instructions using the given compiler

>Save it to the instruction memory using Quartus software

>Send the image using the matlab code and wait till the recieving is complete

Performance

>It takes around 2 minuts for the transmission

>less than 1 second for the downsampling

>ability to downsample maximum of 256x256x3 image

following diagrams shows the architecture, state diagram and datapath of the processor

![Architecture of the processor](images/ARCHI.PNG)

![State diagram of the processor](images/state_diagram.PNG)

![Datapath of the processor](images/datapath.PNG)


