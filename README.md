#  Customer Segmentation Using RFM Analysis in SAS

This project demonstrates how to perform **customer segmentation** using the **RFM (Recency, Frequency, Monetary)** model in **SAS**. It showcases how transactional data can be transformed into business insights using classic analytical techniques and SAS programming.

---

##  Project Files

- `rfm_analysis.sas` – End-to-end SAS code for:
  - Data import and cleaning
  - RFM metric computation
  - Score assignment and segmentation
- `data.csv` – Sample customer transaction data (anonymized)

---

##  Methodology: RFM Model

| Metric    | Description                                                                 |
|-----------|-----------------------------------------------------------------------------|
| **Recency**   | Days since the customer's last purchase                                  |
| **Frequency** | Total number of purchases made                                           |
| **Monetary**  | Total spending amount over all transactions                              |

Each metric is scored from 1 to 5 using **quantile ranking**, and combined into a 3-digit **RFM score** (e.g., `555`, `343`).

---

##  Customer Segments Defined

Based on RFM scores, customers are grouped into actionable segments:

| Segment           | Description                            |
|-------------------|----------------------------------------|
| Champions         | Recent, frequent, and high spenders    |
| Loyal Customers   | Frequent purchasers with good value    |
| Recent Customers  | New buyers with high recency           |
| Big Spenders      | High spenders but low frequency        |
| At Risk           | Haven’t purchased in a long time       |
| Others            | All remaining customers                |

---

##  Tools & Technologies

- **Language:** SAS Base Programming  
- **SAS Procedures:** `PROC IMPORT`, `PROC SQL`, `PROC RANK`, `DATA STEP`
- **Data Handling:** SAS libraries, date functions, conditional logic

---

##  Sample Output

| CustomerID | Recency | Frequency | Monetary | RFM Score | Segment         |
|------------|---------|-----------|----------|-----------|-----------------|
| C001       | 10      | 15        | 3500     | 555       | Champions       |
| C002       | 25      | 10        | 2800     | 444       | Loyal Customers |
| C005       | 100     | 3         | 4000     | 115       | Big Spenders    |

---

##  Insights & Applications

This segmentation model enables businesses to:
- Prioritize marketing efforts
- Personalize promotions by customer value
- Improve retention and engagement strategies

---

##  How to Run

1. Open the SAS environment (SAS Studio or local).
2. Upload `data.csv` and `rfm_analysis.sas`.
3. Run the SAS code in sections or as a whole.
4. View final segments in the `WORK.SEGMENTS` table.

---

##  Author

**Keerthika** – Aspiring Data Scientist & SAS Programmer  
🔗 [LinkedIn Profile](www.linkedin.com/in/keerthika-parthiban-339420266)

---

##  License

This project is open-source and available for academic, learning, and professional portfolio use.

---

