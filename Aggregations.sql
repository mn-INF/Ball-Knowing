'''
PPG, APG, RPG (basic, just getting them out first for all seasons):
'''
  
SELECT season_id, description, first_name, last_name, full_name,
ROUND(pts*1.0/games_played, 2) as ppg,
ROUND(ast*1.0/games_played, 2) as apg,
ROUND(trb*1.0/games_played, 2) as rpg
FROM player_season_stat_totals as psst
JOIN players as pl ON psst.player_id = pl.player_id
JOIN season_types as st ON psst.season_type_id = st.season_type_id
JOIN teams on psst.team_id = teams.team_id
ORDER BY season_id ASC, description DESC, full_name ASC;

'''
Highest PPG, APG, RPG (basic, just getting them out first for all seasons)
- Top 5 for a given season (regular season, playoffs)

Top 5 PPG for 2018-2019 regular season:
'''
SELECT season_id, first_name, last_name, full_name, 
ROUND(SUM(pts*1.0/games_played), 1) as ppg
FROM player_season_stat_totals as psst
JOIN players as pl ON psst.player_id = pl.player_id
JOIN teams on psst.team_id = teams.team_id
WHERE season_type_id = 0 AND season_id = 2018 AND games_played >= 58
GROUP BY season_id, first_name, last_name, full_name
ORDER BY SUM(pts*1.0/games_played) DESC
LIMIT 5;

'''
Top 5 APG for 2008-2009 regular season:
'''
  
SELECT season_id, first_name, last_name, full_name, 
ROUND(SUM(ast*1.0/games_played), 1) as apg
FROM player_season_stat_totals as psst
JOIN players as pl ON psst.player_id = pl.player_id
JOIN teams on psst.team_id = teams.team_id
WHERE season_type_id = 0 AND season_id = 2008 AND games_played >= 58
GROUP BY season_id, first_name, last_name, full_name
ORDER BY SUM(ast*1.0/games_played) DESC
LIMIT 5;

'''
Top 5 APG for 2013-2014 playoffs:
'''

SELECT season_id, first_name, last_name, full_name, 
ROUND(SUM(ast*1.0/games_played), 1) as apg
FROM player_season_stat_totals as psst
JOIN players as pl ON psst.player_id = pl.player_id
JOIN teams on psst.team_id = teams.team_id
WHERE season_type_id = 1 AND season_id = 2013
GROUP BY season_id, first_name, last_name, full_name
ORDER BY SUM(ast*1.0/games_played) DESC
LIMIT 5;

'''
Total points, total assists, total rebounds
  
Top 25 all-time points leaders (as of 2020-2021 regular season):
'''
  
SELECT first_name, last_name, SUM(pts)
FROM player_season_stat_totals as psst
JOIN players as pl ON psst.player_id = pl.player_id
JOIN teams on psst.team_id = teams.team_id
WHERE season_type_id = 0
GROUP BY first_name, last_name
ORDER BY SUM(pts) DESC
LIMIT 25;

'''
Top 25 all-time assist leaders (as of 2020-2021 regular season):
'''
  
SELECT first_name, last_name, SUM(ast)
FROM player_season_stat_totals as psst
JOIN players as pl ON psst.player_id = pl.player_id
JOIN teams on psst.team_id = teams.team_id
WHERE season_type_id = 0
GROUP BY first_name, last_name
ORDER BY SUM(ast) DESC
LIMIT 25;

'''
Top 25 all-time rebound leaders (as of 2020-2021 regular season):
'''
  
SELECT first_name, last_name, SUM(trb)
FROM player_season_stat_totals as psst
JOIN players as pl ON psst.player_id = pl.player_id
JOIN teams on psst.team_id = teams.team_id
WHERE season_type_id = 0 and trb is NOT NULL
GROUP BY first_name, last_name
ORDER BY SUM(trb) DESC
LIMIT 25;
