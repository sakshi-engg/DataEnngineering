CREATE DATABASE MacthesDataset;
use MacthesDataset;

SELECT DISTINCT season FROM dbo.matches;

SELECT TOP 1 winner, win_by_runs FROM dbo.matches ORDER BY win_by_runs DESC;


-- 1. How many seasons we’ve got in the dataset?
SELECT COUNT(DISTINCT season) AS total_seasons FROM matches;

--2. Which Team had won by maximum runs?
SELECT TOP 1 winner, win_by_runs FROM matches ORDER BY win_by_runs DESC;

--3. Which Team had won by maximum wickets?
SELECT winner, COUNT(*) AS times_won_by_10_wickets
FROM matches
WHERE win_by_wickets = 10
GROUP BY winner
ORDER BY times_won_by_10_wickets DESC;

--4. Which Team had won by closest margin (minimum non-zero runs)?
SELECT TOP 1 winner, win_by_runs
FROM matches
WHERE win_by_runs > 0
ORDER BY win_by_runs ASC;

--5. Which Team had won by minimum wickets (non-zero)?
SELECT TOP 1 winner, win_by_wickets
FROM matches
WHERE win_by_wickets > 0
ORDER BY win_by_wickets ASC;

--6. Which Season had most number of matches?
SELECT season, COUNT(*) AS total_matches
FROM matches
GROUP BY season
ORDER BY total_matches DESC;

--7. Which IPL Team is more successful (most wins)?
SELECT winner, COUNT(*) AS total_wins
FROM matches
GROUP BY winner
ORDER BY total_wins DESC;
