'''
Individual Player Stat Queries: LeBron James vs. Michael Jordan
- Yeah we’re doing this.
  
Pulling out LeBron’s averages for EVERYTHING for every season:
''' 

SELECT DISTINCT season_id, CONCAT(first_name, ' ', last_name) as player_name,
full_name,
ROUND(SUM(pts*1.0/games_played), 1) as ppg,
ROUND(SUM(trb*1.0/games_played), 1) as rpg,
ROUND(SUM(ast*1.0/games_played), 1) as apg,
ROUND(SUM(stl*1.0/games_played), 1) as spg,
ROUND(SUM(blk*1.0/games_played), 1) as bpg,
ROUND(SUM((pm_2 + pm_3)*100.0/(pa_2 + pa_3)), 1) as pct_fg,
ROUND(SUM(pm_3*100.0/pa_3), 1) as pct_3,
ROUND(SUM(ftm*100.0/fta), 1) as ftp
FROM player_season_stat_totals as psst
JOIN players as pl ON psst.player_id = pl.player_id
JOIN teams ON psst.team_id = teams.team_id
WHERE first_name LIKE 'LeBron' AND season_type_id = 0
GROUP BY season_id, CONCAT(first_name, ' ', last_name), full_name
ORDER BY season_id DESC;

'''
Same thing for Jordan
'''
  
SELECT season_id, CONCAT(first_name, ' ', last_name) as player_name,
full_name,
ROUND(SUM(pts*1.0/games_played), 1) as ppg,
ROUND(SUM(trb*1.0/games_played), 1) as rpg,
ROUND(SUM(ast*1.0/games_played), 1) as apg,
ROUND(SUM(stl*1.0/games_played), 1) as spg,
ROUND(SUM(blk*1.0/games_played), 1) as bpg,
ROUND(SUM((pm_2 + pm_3)*100.0/(pa_2 + pa_3)), 1) as pct_fg,
ROUND(SUM(pm_3*100.0/pa_3), 1) as pct_3,
ROUND(SUM(ftm*100.0/fta), 1) as ftp
FROM player_season_stat_totals as psst
JOIN players as pl ON psst.player_id = pl.player_id
JOIN teams ON psst.team_id = teams.team_id
WHERE first_name LIKE 'Michael' AND last_name LIKE 'Jordan' AND season_type_id = 0
GROUP BY season_id, CONCAT(first_name, ' ', last_name), full_name
ORDER BY season_id DESC;
