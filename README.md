# FPGA-Based Sobel Edge Detection with Approximate Multipliers

## 📌 Project Overview

This project implements a fully synthesizable Sobel edge detection algorithm using Verilog HDL, suitable for FPGA deployment. The design uses a custom-built approximate unsigned multiplier to significantly reduce power & area consumption , while maintaining edge detection accuracy. It is capable of detecting edges from 8-bit grayscale images in real-time.

---

## 🧱 Modular Architecture

The project is built using a modular RTL architecture consisting of the following components:

- `pixel_window_generator.v` – Generates a 3×3 pixel window using FIFOs and shift registers  
- `sobel_core.v` – Computes Gx and Gy gradients, absolute values, and applies thresholding  
- `Adder_16bit.v` – Custom structural adder (Carry Select Adder)  
- `AppMul_8bitSigned.v` – Approximate unsigned multiplier for power-aware convolution  
- `line_buffer.v` – FIFO-based scanline buffering
- `tb_sobel_image.v` – Testbench for simulating full image-based pipeline  
- **MATLAB Scripts** – For image preprocessing and output visualization  

---

## ✨ Features

- Modular, synthesizable Verilog design  
- Uses approximate unsigned multipliers to reduce dynamic power  
- Fully working 3×3 Sobel edge detection core (Gx, Gy)  
- Threshold-based binary edge map generation  
- Pixel window generation using FIFOs and shift registers  
- Simulation testbench with image input/output support   
- Support for 256×256 grayscale images  

---

## 🎯 Advantages & Perks

- Reduces overall on-chip power & utilization by using approximate logic in arithmetic blocks  
- Flexible design: change threshold, kernels, or multipliers easily  
- Improves hardware efficiency by replacing standard multipliers with approximate units  
- RTL-level image processing pipeline is useful for learning and prototyping  
- Suits low-power edge devices and FPGA-based camera systems  

---

## 🧪 Simulation & Image Flow

1. Convert image to grayscale and resize to 256×256 using MATLAB  
2. Flatten image to CSV using:
   ```matlab
   writematrix(img(:), 'image_data.csv');
