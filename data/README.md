# Data — Project 2: Insurance Fraud Detection

## Dataset: Auto Insurance Claims with Fraud Labels

**Source:** GitHub — mwitiderrick/insurancedata  
**Direct URL:** https://raw.githubusercontent.com/mwitiderrick/insurancedata/master/insurance_claims.csv  
**Downloaded automatically** by the notebook on first run and saved locally as `insurance_claims.csv`

## Dataset Properties

| Property | Value |
|----------|-------|
| Total Claims | 1,000 rows |
| Features | 39 columns |
| Fraudulent Claims | 247 (24.7%) |
| Legitimate Claims | 753 (75.3%) |
| License | Free — public GitHub repository |

## Key Column Descriptions

| Column | Description |
|--------|-------------|
| `fraud_reported` | Target variable: Y = fraud, N = legitimate |
| `total_claim_amount` | Total USD value of the claim |
| `incident_type` | Type of incident (collision, theft, etc.) |
| `incident_severity` | Minor damage / Major damage / Total Loss |
| `number_of_vehicles_involved` | Count of vehicles in the incident |
| `witnesses` | Number of independent witnesses |
| `police_report_available` | Whether a police report was filed |
| `months_as_customer` | Customer tenure in months |
| `policy_annual_premium` | Annual premium paid by policyholder |
| `injury_claim` | Claim amount for personal injury |
| `property_claim` | Claim amount for property damage |
| `vehicle_claim` | Claim amount for vehicle damage |

## Note on Class Imbalance

Only 24.7% of claims are fraudulent. The notebook applies **SMOTE** (Synthetic Minority Oversampling Technique) to the training set only to address this imbalance. The test set is kept at the original 24.7% fraud rate to ensure honest evaluation.
