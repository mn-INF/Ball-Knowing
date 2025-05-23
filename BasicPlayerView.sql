'''
Basic player views

- Season ID/year (i.e. season ID = 2018 -> 2018-2019 season)
- Description (Whether it’s regular season, playoffs, etc.)
- Player’s name (first & last)
- The team(s) they’re on that season
'''

SELECT season_id, description, first_name, last_name, full_name
FROM player_season_stat_totals as psst
JOIN players as pl ON psst.player_id = pl.player_id
JOIN season_types as st ON psst.season_type_id = st.season_type_id
JOIN teams on psst.team_id = teams.team_id
ORDER BY season_id ASC, description DESC, full_name ASC;
