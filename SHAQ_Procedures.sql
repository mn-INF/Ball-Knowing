CREATE OR REPLACE FUNCTION RosterStats(
team_name VARCHAR(100), 
season INT,
season_type INT
)
RETURNS TABLE (szn INT, szn_description VARCHAR(55), 
player_first_name VARCHAR(255), player_last_name VARCHAR(255), full_team_name VARCHAR(100),
ppg DECIMAL, apg DECIMAL, rpg DECIMAL)
AS $$
BEGIN
    RETURN QUERY SELECT season_id, description, first_name, last_name, full_name,
ROUND(pts*1.0/games_played, 2) as ppg,
ROUND(ast*1.0/games_played, 2) as apg,
ROUND(trb*1.0/games_played, 2) as rpg
FROM player_season_stat_totals as psst
JOIN players as pl ON psst.player_id = pl.player_id
JOIN season_types as st ON psst.season_type_id = st.season_type_id
JOIN teams on psst.team_id = teams.team_id
WHERE psst.season_type_id = season_type AND full_name = team_name AND season_id = season
ORDER BY description DESC;
END; 
$$ LANGUAGE plpgsql;

SELECT * FROM RosterStats('Boston Celtics', 2017, 1);
SELECT * FROM RosterStats('Detroit Pistons', 2006, 0);
SELECT * FROM RosterStats('Cleveland Cavaliers', 2015, 1);

CREATE OR REPLACE FUNCTION PPGRank( 
season INT,
player_limit INT
)
RETURNS TABLE (szn INT, player_first_name VARCHAR(255), player_last_name VARCHAR(255), 
full_team_name VARCHAR(100), ppg DECIMAL)
AS $$
BEGIN
    RETURN QUERY SELECT season_id, first_name, 
	last_name, full_name, 
ROUND(SUM(pts*1.0/games_played), 1) as ppg
FROM player_season_stat_totals as psst
JOIN players as pl ON psst.player_id = pl.player_id
JOIN teams on psst.team_id = teams.team_id
WHERE season_type_id = 0 AND season_id = season AND games_played >= 58
GROUP BY season_id, first_name, last_name, full_name
ORDER BY SUM(pts*1.0/games_played) DESC
LIMIT player_limit;
END; 
$$ LANGUAGE plpgsql;

SELECT * FROM PPGRank(2012, 10)

CREATE OR REPLACE FUNCTION APGRank( 
season INT,
player_limit INT
)
RETURNS TABLE (szn INT, player_first_name VARCHAR(255), player_last_name VARCHAR(255), 
full_team_name VARCHAR(100), apg DECIMAL)
AS $$
BEGIN
    RETURN QUERY SELECT season_id, first_name, 
	last_name, full_name, 
ROUND(SUM(ast*1.0/games_played), 1) as apg
FROM player_season_stat_totals as psst
JOIN players as pl ON psst.player_id = pl.player_id
JOIN teams on psst.team_id = teams.team_id
WHERE season_type_id = 0 AND season_id = season AND games_played >= 58
GROUP BY season_id, first_name, last_name, full_name
ORDER BY SUM(ast*1.0/games_played) DESC
LIMIT player_limit;
END; 
$$ LANGUAGE plpgsql;

SELECT * FROM APGRank(2019, 5)

CREATE OR REPLACE FUNCTION RPGRank( 
season INT,
player_limit INT
)
RETURNS TABLE (szn INT, player_first_name VARCHAR(255), player_last_name VARCHAR(255), 
full_team_name VARCHAR(100), rpg DECIMAL)
AS $$
BEGIN
    RETURN QUERY SELECT season_id, first_name, 
	last_name, full_name, 
ROUND(SUM(trb*1.0/games_played), 1) as rpg
FROM player_season_stat_totals as psst
JOIN players as pl ON psst.player_id = pl.player_id
JOIN teams on psst.team_id = teams.team_id
WHERE season_type_id = 0 AND season_id = season AND games_played >= 58
GROUP BY season_id, first_name, last_name, full_name
ORDER BY SUM(trb*1.0/games_played) DESC
LIMIT player_limit;
END; 
$$ LANGUAGE plpgsql;

SELECT * FROM RPGRank (2008, 3)

CREATE OR REPLACE FUNCTION PlayerHistory( 
p_first_name VARCHAR(255),
p_last_name VARCHAR(255),
season_type INT
)
RETURNS TABLE (szn INT, f_name VARCHAR(255), l_name VARCHAR(255),
full_team_name VARCHAR(100), ppg DECIMAL, apg DECIMAL, rpg DECIMAL,
spg DECIMAL, bpg DECIMAL, pct_fg DECIMAL, pct_3 DECIMAL, ftp DECIMAL)
AS $$
BEGIN
    RETURN QUERY SELECT DISTINCT season_id, first_name, last_name,
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
WHERE first_name LIKE p_first_name AND last_name LIKE p_last_name AND season_type_id = season_type
GROUP BY season_id, first_name, last_name, full_name
ORDER BY season_id DESC;
END; 
$$ LANGUAGE plpgsql;

SELECT * FROM PlayerHistory(‘Kobe’, ‘Bryant’, 1)

SELECT * FROM PlayerHistory(‘LeBron’, ‘James’, 0)