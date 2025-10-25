# State-of-Health Estimation of Lithium-ion Battery for Enhanced Electric Vehicle Safety

## Overview
Lithium-ion batteries (LIBs) are central to the operation of Electric Vehicles (EVs) due to their high energy density and long lifespan.  
However, their performance deteriorates over time, which can compromise safety and efficiency.  
Accurate **State of Health (SOH)** estimation is therefore essential to monitor degradation, predict lifespan, and ensure safe battery operation.  

This project proposes a **simple, lightweight, and real-time compatible method** for SOH estimation using **voltage–time data** recorded during constant current charging, without requiring the battery’s internal electrochemical parameters.

---

## Motivation
- Lithium-ion batteries degrade with time, reducing EV safety and performance.  
- Many existing SOH estimation approaches are complex, computationally demanding, or require internal model data.  
- The goal of this work is to design a **simple, accurate, and empirical method** that is fast enough for **real-time use in BMS (Battery Management Systems)**.  

---

## Objectives
- Develop a simplified and efficient SOH prediction technique using measurable electrical data.  
- Achieve high accuracy with minimal computational requirements.  
- Ensure **real-time compatibility** with on-board Battery Management Systems.  
- Eliminate the dependence on internal parameters such as resistance, capacitance, or diffusion coefficients.  

---

## Methodology

### 1. Model Development
A second-order **Equivalent Circuit Model (2-RC ECM)** was adopted to simulate the behavior of the lithium-ion battery cell.  
It consists of:
- **VOCV**: Open-circuit voltage source (a nonlinear function of SOC).  
- **Resr**: Electrolyte resistance.  
- Two RC branches: Representing activation and concentration polarization.  

**Identified Parameters (via Pulse Cycling Method):**
- Resr = 0.0414 Ω  
- R1 = 0.0292 Ω  
- R2 = 0.0154 Ω  
- C1 = 1.0984 × 10³ F  
- C2 = 3.8849 × 10⁴ F  

The model was validated under **C/2-rate constant current charging**, as shown in the simulation results.  

---

### 2. Feature Extraction
Two key features were extracted from voltage–time charging data obtained at known SOH levels (100%, 95%, 90%, 85%, and 80%):

1. **T₄V** – Time taken to reach 4.0 V  
2. **Slope** – Rate of voltage change between 3.8 V and 4.0 V  

As aging progresses:  
- The **charging duration decreases** (lower T₄V).  
- The **voltage rise rate increases** (higher slope).  

This feature relationship is used as the basis for mapping unknown voltage–time profiles to SOH values.  

---

### 3. Regression-Based SOH Estimation
The extracted features (Slope and T₄V) were used to train a **Support Vector Regression (SVR)** model in MATLAB.  
This model predicts the SOH of an unknown cell using feature pairs derived from its charging curves.  

Advantages of this approach:  
- Low data requirements  
- Empirical and hardware-friendly  
- High suitability for real-time estimation on embedded BMS hardware  

---

## Results
Two test cases were evaluated using unknown voltage–time profiles:

| Case | Slope (V/s) | T₄V (h) | Predicted SOH (%) | Actual SOH (%) | Error (%) |
|------|--------------|----------|-------------------|----------------|-----------|
| 1 | 0.002919 | 1.14 | 88.06 | 87–89 | 1.22 |
| 2 | 0.002654 | 1.36 | 99.10 | 98–100 | 1.12 |

**Performance Summary:**
- Prediction error remains under **1.2%** across all test cases.  
- Model captures the aging trend accurately using only voltage–time data.  
- The regression approach confirms **validity for real-time SOH estimation** in embedded systems.

---

## Key Contributions
- **No need for internal battery parameters**  
- **Only voltage–time data used**, reducing complexity  
- **Lightweight model** suitable for implementation on low-power processors  
- Enables **plug-and-play integration** with existing Battery Management Systems  

---

## Conclusion
The developed technique offers a **reliable, simple, and efficient** approach to estimating the health of lithium-ion batteries.  
It ensures accurate SOH prediction with less than 1.2% error and negligible computational cost.  
Because the system depends only on easily measurable variables, it is ideal for **real-time implementation in electric vehicle BMS**.

---

## Future Scope
- Validate the method with experimental battery charge–discharge data.  
- Integrate **temperature-dependent compensation** to enhance model accuracy.  
- Implement this algorithm on an **STM32 microcontroller** for on-board EV applications.  
- Extend the methodology to also estimate **State of Charge (SOC)** and **Remaining Useful Life (RUL)**.  

---

