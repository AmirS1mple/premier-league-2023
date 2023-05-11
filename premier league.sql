/*

   premier league 2022/2023 database 
   This project is about the statistics of this premier league season which contains
   name of teams, how many goals they scored or conceded in the home and away matches, how many red or yellow cards their player take in home and away
   and also an insight about referees.

   Author: Amir Vahdati
   Email: Amir.vahdati.1997@gmail.com

   */

 

 -- How many home games have each team played?
SELECT HomeTeam, COUNT(HomeTeam) AS HomeMatches FROM epl_results
GROUP BY HomeTeam;

 -- How many away games have each team played?
SELECT AwayTeam, COUNT(AwayTeam) AS AwayMatches FROM epl_results
GROUP BY AwayTeam;

-- Calculate Number of home wins,away wins and draws
SELECT COUNT(*) AS total_games,
       (SELECT COUNT(*) FROM epl_results WHERE FTHG > FTAG) AS home_wins,
       (SELECT COUNT(*) FROM epl_results WHERE FTHG < FTAG) AS away_wins,
       (SELECT COUNT(*) FROM epl_results WHERE FTHG = FTAG) AS draw
FROM epl_results;

-- Calculate percentage of home wins
SELECT
ROUND((SELECT COUNT(*) FROM epl_results WHERE FTHG > FTAG) * 100.0 / COUNT(*),2) AS home_win_percentage
FROM epl_results

-- Calculate percentage of away wins
SELECT
ROUND((SELECT COUNT(*) FROM epl_results WHERE FTAG > FTHG) * 100.0 / COUNT(*),2) AS away_win_percentage
FROM epl_results

-- Sum count of goals for every team in their home matches
SELECT HomeTeam, SUM(FTHG) AS most_scored FROM epl_results
GROUP BY HomeTeam
ORDER BY HomeTeam ASC;

-- Sum count of goals for every team in their away matches
SELECT AwayTeam, SUM(FTAG) AS most_scored_away FROM epl_results
GROUP BY AwayTeam
ORDER BY AwayTeam ASC;

-- Sum count of yellow cards for every team in their home matches
SELECT HomeTeam, SUM(HY) AS  Home_yellow_cards FROM epl_results
GROUP BY HomeTeam
ORDER BY HomeTeam ASC;

-- Sum count of yellow cards for every team in their away matches
SELECT AwayTeam, SUM(AY) AS  Away_yellow_cards FROM epl_results
GROUP BY AwayTeam
ORDER BY AwayTeam ASC;

-- Sum count of red cards for every team in their home matches
SELECT HomeTeam, SUM(HR) AS  Home_red_cards FROM epl_results
GROUP BY HomeTeam
ORDER BY HomeTeam ASC;

-- Sum count of red cards for every team in their away matches 
SELECT AwayTeam, SUM(AR) AS  Away_red_cards FROM epl_results
GROUP BY AwayTeam
ORDER BY AwayTeam ASC;


-- Sum count of fouls for every team in their home matches
SELECT HomeTeam, SUM(HF) AS  Home_fouls FROM epl_results
GROUP BY HomeTeam
ORDER BY HomeTeam ASC;

-- Sum count of fouls for every team in their away matches
SELECT AwayTeam, SUM(AF) AS  AwayTeam_fouls FROM epl_results
GROUP BY AwayTeam
ORDER BY AwayTeam ASC;

-- Sum count of shots for teams in their home matches
SELECT HomeTeam, SUM(HS) AS  Home_shots FROM epl_results
GROUP BY HomeTeam
ORDER BY HomeTeam ASC;

-- Sum count of shots on target in their home matches
SELECT HomeTeam, SUM(HSt) AS  Home_shoots_target FROM epl_results
GROUP BY HomeTeam
ORDER BY HomeTeam ASC;

-- Sum count of shots for teams in their away matches
SELECT AwayTeam, SUM([AS]) AS  Away_shoots FROM epl_results
GROUP BY AwayTeam
ORDER BY AwayTeam ASC;

-- Sum count of shots on target for teams in their away matches
SELECT AwayTeam, SUM(AST) AS  Away_shoots_target FROM epl_results
GROUP BY AwayTeam
ORDER BY AwayTeam ASC;

-- Sum count of corners for every team in their home matches 
SELECT HomeTeam, SUM(HC) AS  Home_corners FROM epl_results
GROUP BY HomeTeam
ORDER BY HomeTeam ASC;

-- Sum count of corners for every team in their away matches 
SELECT AwayTeam, SUM(AC) AS  Away_corners FROM epl_results
GROUP BY AwayTeam
ORDER BY AwayTeam ASC;

-- Detect a match that home side scored tho most goals
SELECT HomeTeam,AwayTeam,FTHG,FTAG
FROM epl_results
WHERE FTHG=(
    SELECT
    MAX(FTHG)
    FROM epl_results);

-- Detect a match that away side scored tho most goals
	SELECT HomeTeam,AwayTeam,FTHG,FTAG
FROM epl_results
WHERE FTAG=(
    SELECT
    MAX(FTAG)
    FROM epl_results);


-- Show the most scored team against their rivals when they were host and scord at least 3 goals
SELECT HomeTeam, AwayTeam, MAX(FTHG) AS BestResult
FROM epl_results
WHERE FTHG >=3
GROUP BY HomeTeam, AwayTeam,FTHG
ORDER BY FTHG DESC;

-- Show the most scored team against their rivals when they were guest and scord at least 3 goals
SELECT HomeTeam, AwayTeam, MAX(FTAG) AS BestResult
FROM epl_results
WHERE FTAG >=3
GROUP BY AwayTeam, HomeTeam,FTAG
ORDER BY FTAG DESC;

-- Sum count of yellow cards for home teams
SELECT HomeTeam, SUM(HY) AS Home_yellow_cards 
FROM epl_results  
GROUP BY HomeTeam;

-- Sum count of yellow cards for away teams
SELECT AwayTeam, SUM(AY) AS Away_yellow_cards 
FROM epl_results  
GROUP BY AwayTeam;


-- Count how many yellow cards each referee gave to home teams
SELECT referee, HomeTeam, SUM(HY) AS Home_Yellow_Cards
FROM epl_results
WHERE HY>0
GROUP BY referee, HomeTeam	

-- Count how many yellow cards each referee gave to away teams
SELECT referee, AwayTeam, SUM(AY) AS Home_Yellow_Cards
FROM epl_results
WHERE AY>0
GROUP BY referee, AwayTeam;

-- Count how many red cards each referee gave to home teams
SELECT referee, HomeTeam, SUM(HR) AS Home_Red_Cards
FROM epl_results
WHERE HR>0
GROUP BY referee, HomeTeam;

-- Count how many red cards each referee gave to away teams
SELECT referee, AwayTeam, SUM(AR) AS Away_Red_Cards
FROM epl_results
WHERE AR>0
GROUP BY referee, AwayTeam;

-- Calculate average number of yellow cards for each referee
SELECT  AVG((HY+AY) * 1.0) AS avg_yellow_cards
FROM epl_results
GROUP BY Referee

-- Calculate average number of red cards for each referee
SELECT referee, AVG((HR+AR * 1.0)) AS avg_Red_cards
FROM epl_results
GROUP BY Referee
