# 🔋 Feature-Driven SOH Estimation for Lithium-ion Batteries in EVs

## A Lightweight Support Vector Regression (SVR) Approach for BMS Integration

[cite_start]This repository contains the methodology and code implementation for a novel State-of-Health (SOH) estimation technique for Lithium-ion Batteries (LIBs), specifically designed for **real-time compatibility with Battery Management Systems (BMS)** in Electric Vehicles (EVs)[cite: 5, 13, 22].

---

## 🌟 Project Overview

[cite_start]The project addresses the critical challenge posed by the complexity and data intensity of traditional SOH estimation methods[cite: 10, 110, 109]. [cite_start]Our goal is to develop a **simple, lightweight, and empirically validated** technique that uses easily measurable external battery data[cite: 11, 22, 110].

[cite_start]The ultimate goal is to enable real-time battery health monitoring to prevent battery abuse and enhance EV safety[cite: 13, 23, 117].

### Key Achievements

* [cite_start]**Accuracy:** Achieved prediction accuracy with an **Absolute Percentage Error under 1.2%**[cite: 61, 259, 112].
* [cite_start]**Efficiency:** Requires **only voltage-time data** during constant current charging, eliminating the need for internal battery parameters[cite: 94, 137, 262].
* [cite_start]**Compatibility:** The simplified approach is compatible with embedded BMS hardware[cite: 95, 140, 263].

---

## 🛠️ Methodology: Feature Engineering & SVR

[cite_start]Our method leverages the observable relationship that as SOH decreases, the voltage-time curve shifts upward, reaching the upper cutoff voltage in a shorter time[cite: 70, 88, 220].

### 1. Model Basis

[cite_start]A **second-order Equivalent Circuit Model (2RC ECM)** was used initially for parameter estimation and to simulate the electrical performance of the LIB cell[cite: 26, 44, 64, 144]. This established the foundation for studying voltage behavior.

### 2. Extracted Features (The Input Vector $\mathbf{X}$)

Two critical, easy-to-extract features serve as the inputs for the SVR model:

| Feature | Definition | SOH Correlation | MATLAB Extraction Method |
| :--- | :--- | :--- | :--- |
| **$T_{4V}$** | [cite_start]Time taken (in hours) for the terminal voltage to reach $\mathbf{4.0\text{V}}$ during CC charging[cite: 31, 213]. | [cite_start]Directly reflects capacity loss (decreases as SOH falls)[cite: 70, 220]. | Determined by index finding: $\mathbf{time}(\mathbf{idx\_4v})$. |
| **Slope ($\frac{dV}{dt}$)** | [cite_start]Rate of voltage change in the region between $\mathbf{3.8\text{V}}$ and $\mathbf{4.0\text{V}}$[cite: 31, 214]. | Captures the change in polarization resistance. | Calculated via $\mathbf{polyfit}(\dots, 1)$ on the voltage segment. |

### 3. SOH Prediction Model (SVR)

[cite_start]A **Support Vector Regression (SVR)** model is trained on the known feature set ($\mathbf{X}$) and corresponding SOH labels ($\mathbf{Y}$)[cite: 111, 240]. [cite_start]SVR was chosen for its ability to handle non-linear mapping while remaining computationally efficient for real-time applications[cite: 112, 139].

---

## 💻 Code Structure (MATLAB)

The workflow is implemented in MATLAB, integrating data processing and machine learning:

1.  **Data Initialization**: Load known SOH profiles (100\% to 80\%).
2.  **Feature Extraction**: A $\mathbf{FOR}$ loop iterates through all known profiles to compute $T_{4V}$ and Slope, populating the training matrix $\mathbf{X}$.
3.  **Training**: The model is trained using $\mathbf{fitrsvm}(\mathbf{X}, \mathbf{Y}, \text{'KernelFunction', 'rbf', } \text{'Standardize', true})$.
4.  **Prediction**: Features ($\mathbf{features\_u}$) from an unknown profile are extracted and fed to the model using $\mathbf{predict}(\mathbf{mdl}, \mathbf{features\_u})$.

## 📊 Performance Validation

The technique demonstrated high accuracy on unseen test cases:

| Case | [cite_start]Actual SOH Range [cite: 61] | [cite_start]Predicted SOH (\%) [cite: 61] | [cite_start]Absolute Error Range (\%) [cite: 61] |
| :--- | :--- | :--- | :--- |
| **CASE 1** | [87-89]\% | 88.06\% | [1.22, 1.06]\% |
| **CASE 2** | [98-100]\% | 99.10\% | [1.12, 0.90]\% |

[cite_start]The minimal error confirms the reliability of using these two features for accurate SOH monitoring[cite: 259, 112].

---

## 🚀 Future Scope

The robust foundation allows for direct continuation into practical deployment:

* [cite_start]**Validation:** Testing with **real experimental charging data** at various SOH levels[cite: 97, 265].
* [cite_start]**Extension:** Expanding the method to include the effect of **temperature variation** for comprehensive SOH estimation[cite: 98, 266].
* [cite_start]**Deployment:** Integration and validation onto an **$\text{STM32}$-based plug-and-play IoT system**[cite: 98, 267].

---

## 🎓 Author and Affiliation

* **Student:** Pinki Saini (Roll no.: 22110194)
* **Department:** Electrical Engineering, IIT Gandhinagar
* [cite_start]**Advisor:** Dr. Pallavi Bharadwaj, Smart Power Electronics Laboratory (SPEL) [cite: 6]