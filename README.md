# 🔍 Insurance Claims Fraud Detection System
*P&C Insurance | Python | SQL | Scikit-learn | SMOTE | Business Impact Analysis*

---

## 📋 Business Problem
Insurance fraud costs the global industry **$80+ billion per year**. This project builds an end-to-end ML fraud detection pipeline that flags suspicious claims before payment and quantifies the net financial benefit.

---

## 🎯 Key Results

| Metric | Value |
|--------|-------|
| Best Model | Gradient Boosting |
| AUC-ROC Score | ~0.88–0.92 |
| Dataset Size | 1,000 claims × 39 features |
| Fraud Rate | 24.7% (class imbalance handled via SMOTE) |
| Models Compared | Logistic Regression, Random Forest, Gradient Boosting |
| Business Impact | Net savings quantified in USD |

---

## 📊 Key Visualisations

> ROC Curves | Confusion Matrix | Feature Importance | Fraud Pattern Analysis

*(Run the notebook — all charts auto-save to /images)*

---

## 🔧 Methodology

1. **SQL Pattern Analysis** — Fraud rate by incident type, claim tier, red-flag combinations, tenure
2. **EDA** — Visual fraud discovery across all 39 features
3. **Preprocessing** — Label encoding, missing value imputation, drop identifier columns
4. **SMOTE** — Synthetic minority oversampling to balance 24.7% fraud rate in training data
5. **Model Training** — 3 models trained and compared on balanced data
6. **Evaluation** — AUC-ROC, Precision-Recall, Confusion Matrix
7. **Business Impact** — Dollar savings from caught fraud minus investigation costs

---

## 💡 Key Insights

- No police report + zero witnesses → highest fraud probability combination
- Multi-vehicle incidents show disproportionately high fraud rates
- New customers (under 12 months) carry significantly higher fraud risk
- SMOTE is critical — without it, 75% "predict all legit" baseline masks total model failure
- Gradient Boosting outperforms on AUC-ROC across all thresholds

---

## 🛠️ Tools & Technologies
`Python` `SQL` `SQLite` `Scikit-learn` `imbalanced-learn` `SMOTE` `Pandas` `Matplotlib` `Seaborn`

---

## 🗂️ Dataset
**Source:** GitHub — mwitiderrick/insurancedata (Auto Insurance Claims)  
**Link:** https://github.com/mwitiderrick/insurancedata  
**Size:** 1,000 rows × 39 columns | Fraud rate: 24.7%

---

## 🚀 How to Run

```bash
git clone https://github.com/aryansinghal21-data/insurance-fraud-detection
cd insurance-fraud-detection
pip install -r requirements.txt
jupyter notebook notebooks/fraud_detection.ipynb
```

> **Note:** Run **Kernel → Restart & Run All** to execute all cells in order.

---

## 📁 Project Structure

```
insurance-fraud-detection/
├── notebooks/
│   └── fraud_detection.ipynb
├── sql/
│   └── fraud_queries.sql
├── images/
│   └── (auto-generated charts)
├── data/
│   └── insurance_claims.csv (auto-downloaded)
├── requirements.txt
└── README.md
```

---

## 👤 Author
Aryan Singhal | Aspiring Actuarial Data Analyst  
[LinkedIn](https://www.linkedin.com/in/aryansinghal21/) | [Email](mailto:aryansinghal821@gmail.com)
