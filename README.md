# Logistics & Supply Chain Efficiency Audit: SLA Risk & ROI Modeling
**Technical Stack:** SAS 9.4, PROC SQL, Predictive Modeling (Logistic Regression)

## 🚀 Project Overview
This project identifies operational inefficiencies in a high-volume (50,000 records) last-mile delivery ecosystem. By analyzing transit latency and fleet performance, I identified a vehicle-to-route mismatch resulting in approximately **$20,000/month** in automated customer refunds.

The primary goal was to transition from descriptive reporting to **prescriptive strategy**, identifying the exact threshold where specific vehicle types become a financial liability.

## 📊 Key Findings
* **The E-Bike Breakpoint:** While E-Bikes are cost-effective for local trips, they exhibit a "critical failure" threshold. Beyond **4.5 KM**, the probability of an SLA breach (30-min window) nears 100%.
* **Operational Waste:** E-Bike deliveries carried an average "refund risk" of **$1.33 per unit**, compared to effectively **$0.00** for the Sedan fleet.
* **Systemic Volatility:** Using a Multivariate Logistic Regression, I proved that **Traffic Index** ($p < .0001$) and **Vehicle Type** ($p < .0001$) were the primary drivers of loss, while geographic **Zone** was statistically insignificant ($p = 0.9115$).

## 💰 Financial Impact (Annualized ROI)
By implementing a dynamic dispatch cap (restricting E-Bikes to sub-4.5 KM routes), the projected cost-avoidance is:
* **Monthly Savings:** $19,982.00
* **Annualized ROI:** **$239,784.00**

## 📂 Repository Structure
* `01_data_generation.sas`: Synthetic data engine simulating 1,000 drivers and 50,000 deliveries using Latent Variable Simulation.
* `02_exploratory_analysis.sas`: Statistical summaries, hourly stress-tests, and visualization of system bottlenecks.
* `03_predictive_modeling.sas`: Multivariate Logistic Regression and Counterfactual Financial Audit.
* `/visuals`: Exported PNGs including the "E-Bike Breakpoint" and "System Latency" charts.

## 🛠️ Methodology & Technical Skills
* **Data Engineering:** Simulated complex datasets using nested `DO` loops and `call streaminit` in SAS.
* **Advanced SQL:** Utilized subqueries and calculated clauses in `PROC SQL` for financial "What-If" modeling.
* **Predictive Analytics:** Applied Binary Logit models to isolate feature importance and evaluate model performance (Concordance = 99.9%).

---
*Note: This dataset was simulated in SAS 9.4 for independent research purposes to demonstrate proficiency in operational analytics and financial modeling.*
