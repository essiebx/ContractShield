-- ============================================
-- Data Collection: Recent Ethereum Contracts
-- Source: BigQuery Ethereum Public Dataset
-- ============================================

-- Get 200 recent contracts from January 1, 2024
CREATE OR REPLACE TABLE `ethereum-risk-assessment.eth_risk_assessment.recent_contracts` AS
SELECT 
  address,
  block_timestamp,
  block_number,
  is_erc20,
  is_erc721
FROM `bigquery-public-data.crypto_ethereum.contracts`
WHERE DATE(block_timestamp) = '2024-01-01'
LIMIT 200;