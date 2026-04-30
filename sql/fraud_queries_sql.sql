-- ============================================================
-- PROJECT 2: Insurance Claims Fraud Detection System
-- SQL Queries for Fraud Pattern Analysis
-- ============================================================


-- ── QUERY 1: Fraud Rate by Incident Type ────────────────────
-- Business Use: Identifies which incident types carry the
-- highest fraud risk — informs rule-based pre-screening

SELECT incident_type,
       COUNT(*)                                                        AS total_claims,
       SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END)          AS fraud_count,
       ROUND(100.0 * SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END)
             / COUNT(*), 1)                                            AS fraud_rate_pct,
       ROUND(AVG(total_claim_amount), 0)                               AS avg_claim_usd
FROM   claims
GROUP  BY incident_type
ORDER  BY fraud_rate_pct DESC;


-- ── QUERY 2: Fraud Rate by Claim Size Tier ──────────────────
-- Business Use: Are high-value claims more fraudulent?
-- Guides investigation resource allocation by claim amount

SELECT CASE
           WHEN total_claim_amount > 80000 THEN '4. Very High (>80K)'
           WHEN total_claim_amount > 50000 THEN '3. High (50K-80K)'
           WHEN total_claim_amount > 20000 THEN '2. Medium (20K-50K)'
           ELSE '1. Low (<20K)'
       END                                                             AS claim_tier,
       COUNT(*)                                                        AS total_claims,
       SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END)          AS fraud_count,
       ROUND(100.0 * SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END)
             / COUNT(*), 1)                                            AS fraud_rate_pct,
       ROUND(AVG(total_claim_amount), 0)                               AS avg_claim_usd
FROM   claims
GROUP  BY claim_tier
ORDER  BY claim_tier;


-- ── QUERY 3: Red Flag Combinations ──────────────────────────
-- Business Use: No police report + no witnesses is the
-- strongest fraud signal — used to build investigation rules

SELECT police_report_available,
       witnesses,
       COUNT(*)                                                        AS total_claims,
       SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END)          AS fraud_count,
       ROUND(100.0 * SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END)
             / COUNT(*), 1)                                            AS fraud_rate_pct
FROM   claims
GROUP  BY police_report_available, witnesses
ORDER  BY fraud_rate_pct DESC
LIMIT  10;


-- ── QUERY 4: Fraud Rate by Customer Tenure ──────────────────
-- Business Use: New customers carry higher fraud risk.
-- Informs underwriting controls for new policy applications

SELECT CASE
           WHEN months_as_customer < 12  THEN '1. New (<1yr)'
           WHEN months_as_customer < 36  THEN '2. Growing (1-3yr)'
           WHEN months_as_customer < 120 THEN '3. Established (3-10yr)'
           ELSE '4. Loyal (10yr+)'
       END                                                             AS tenure_band,
       COUNT(*)                                                        AS customers,
       SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END)          AS fraud_count,
       ROUND(100.0 * SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END)
             / COUNT(*), 1)                                            AS fraud_rate_pct,
       ROUND(AVG(total_claim_amount), 0)                               AS avg_claim_usd
FROM   claims
GROUP  BY tenure_band
ORDER  BY tenure_band;


-- ── QUERY 5: Fraud by Vehicle Involvement ───────────────────
-- Business Use: Multi-vehicle incidents show disproportionate
-- fraud rates — key feature for ML model and manual review

SELECT number_of_vehicles_involved,
       COUNT(*)                                                        AS total_claims,
       ROUND(100.0 * SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END)
             / COUNT(*), 1)                                            AS fraud_rate_pct,
       ROUND(AVG(total_claim_amount), 0)                               AS avg_claim_usd
FROM   claims
GROUP  BY number_of_vehicles_involved
ORDER  BY number_of_vehicles_involved;


-- ── QUERY 6: High-Risk Profile Identification ───────────────
-- Business Use: Combines multiple red flags to surface
-- the claims most likely to require SIU investigation

SELECT policy_number,
       incident_type,
       incident_severity,
       total_claim_amount,
       witnesses,
       police_report_available,
       fraud_reported,
       CASE
           WHEN police_report_available = 'NO'
            AND witnesses = 0
            AND total_claim_amount > 50000 THEN 'VERY HIGH RISK'
           WHEN police_report_available = 'NO'
            AND witnesses = 0             THEN 'HIGH RISK'
           WHEN total_claim_amount > 80000 THEN 'ELEVATED RISK'
           ELSE 'STANDARD'
       END                                                             AS investigation_priority
FROM   claims
ORDER  BY investigation_priority, total_claim_amount DESC
LIMIT  20;


-- ── QUERY 7: Financial Exposure by Fraud Status ─────────────
-- Business Use: Quantifies total dollar exposure from
-- fraud vs legitimate claims in the portfolio

SELECT fraud_reported,
       COUNT(*)                                                        AS claim_count,
       ROUND(SUM(total_claim_amount), 0)                               AS total_exposure_usd,
       ROUND(AVG(total_claim_amount), 0)                               AS avg_claim_usd,
       ROUND(MIN(total_claim_amount), 0)                               AS min_claim_usd,
       ROUND(MAX(total_claim_amount), 0)                               AS max_claim_usd
FROM   claims
GROUP  BY fraud_reported;
