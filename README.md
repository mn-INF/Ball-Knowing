# Ball-Knowing

![image](https://github.com/user-attachments/assets/52b646a6-27aa-4c7d-8d1d-7095bf1fd2bb)

Location for SQL queries on the Shared Hoops Database for Accessible Querying (SHAQ) (https://www.dolthub.com/repositories/teltorob/SHAQ/schema/main)

While I was learning how to make queries in SQL, I downloaded multiple tables of basketball data and combined them into a SQL database. 

The downloaded tables in the schema include:
- League seasons
- Leagues (NBA/ABA)
- Player season stat totals
- Players
- Season types (regular season = 0, playoffs = 1)
- Team seasons
- Teams

![image](https://github.com/user-attachments/assets/015ef711-d6ed-4a92-b206-a34cabf39ddc)


This repository and the queries along with it are a fun take on working on new SQL queries to derive insights about NBA players and teams.

MISCELLANEOUS GUIDELINES:
- snake_case, not camelCase
- No special characters in names (e.g. Luka Doncic, not Luka Dončić). This decision makes it easier to match players to different public data sources, most of which do not use special characters.
- A season_type differentiates both team_seasons and player_seasons between preseason, regular season, playoffs, all-star, etc.
