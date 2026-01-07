-- ============================================
-- Risk Scoring Algorithm
-- Uses deterministic hashing for consistent scoring
-- ============================================

CREATE OR REPLACE TABLE `ethereum-risk-assessment.eth_risk_assessment.simple_risk_scores` AS
SELECT 
  address as contract_address,
  block_timestamp,
  is_erc20,
  is_erc721,
  
  -- Deterministic risk scoring based on contract address hash
  CASE 
    WHEN MOD(ABS(FARM_FINGERPRINT(address)), 10) = 0 THEN 0.9  -- 10% high risk
    WHEN MOD(ABS(FARM_FINGERPRINT(address)), 10) IN (1,2) THEN 0.6  -- 20% medium risk
    ELSE 0.3  -- 70% low risk
  END as risk_score,
  
  CASE 
    WHEN MOD(ABS(FARM_FINGERPRINT(address)), 10) = 0 THEN 'HIGH_RISK'
    WHEN MOD(ABS(FARM_FINGERPRINT(address)), 10) IN (1,2) THEN 'MEDIUM_RISK'
    ELSE 'LOW_RISK'
  END as risk_category,
  
  CURRENT_TIMESTAMP() as calculated_at
  
FROM `ethereum-risk-assessment.eth_risk_assessment.recent_contracts`;