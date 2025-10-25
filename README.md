# State-of-Health Estimation of Lithium-ion Battery for Enhanced Electric Vehicle Safety

## Overview
Lithium-ion batteries (LIBs) are the core energy source in Electric Vehicles (EVs) due to their high energy density and long cycle life. Battery degradation over time affects EV safety and reliability. Estimating the State of Health (SOH) of these batteries is essential for optimal performance, safety, and longevity.

This repository presents a simple and efficient SOH estimation technique that uses only voltage–time data measured during constant current charging, allowing real-time compatibility with battery management systems (BMS) in electric vehicles.

---

## Motivation
Accurate SOH monitoring allows EV users and manufacturers to track battery aging, optimize usage, and safeguard against failures. Existing techniques are often complex, data-intensive, or unsuitable for real-time use on embedded systems. This project closes that gap with a practical, computationally lightweight method.

---

## Methodology

### 1. Literature Review
- Electrochemical model-based methods yield high accuracy but demand heavy computation and detailed battery parameters, making them impractical for real-time embedded use.
- Machine learning methods, while flexible, often require large labeled datasets covering a wide range of conditions.
- Empirical and equivalent circuit models offer a good balance of simplicity, speed, and external observability, but are often based only on basic electrical measurements.

### 2. Proposed Approach
This approach uses two easy-to-measure features from a battery's constant current charging profile:

- **T₄V:** Time taken to reach 4.0 V.
- **Slope:** Voltage rise rate between 3.8 V and 4.0 V.

These features are obtained from voltage–time curves recorded at various SOH levels and used as input for a support vector regression (SVR) model to predict the battery’s SOH.

---

## Key Results

| Case | Slope (V/s) | T₄V (h) | Predicted SOH (%) | Actual SOH (%) | Error (%) |
|------|-------------|---------|-------------------|----------------|-----------|
| 1 | 0.002919 | 1.14 | 88.06 | 87–89 | 1.22 |
| 2 | 0.002654 | 1.36 | 99.10 | 98–100 | 1.12 |

- The SVR model gives SOH predictions with an absolute error within 1.2%.
- Only two voltage features are required—making the approach suitable for embedded or real-time systems.

---

## Advantages
- Uses only **external voltage–time measurements** (no need for internal chemical or physical parameters).
- Computationally simple—**suitable for microcontroller-based BMS**.
- Reliable and accurate (error < 1.2% in prediction testing).

---

## Future Work
- Validate the method with real-world experimental charge data.
- Integrate temperature compensation for broader applicability.
- Embed the algorithm into STM32 or similar microcontrollers for plug-and-play IoT solutions in next-gen EVs.

---


