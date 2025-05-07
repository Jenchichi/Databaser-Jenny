## Joins

#### Relationer
Det vanliga i relationsdatabaser är dock att man har flera tabeller där data i tabell A har en relation till data i tabell B
Att man delar upp data i flera tabeller beror på att man inte vill ha flera kopior av samma data. 

#### Primary and foreign Keys
Med SQL-kommandot "join" kan vi länka ihop data från två eller flera

#### Cross Join
Den gör en uppräkning av alla. För varje i vänster listar vi alla i höger. 

#### Junction table
Exemplet ovan är en så kallad "One to many"-relation. Varje land kan ha flera städer, men varje stad kan bara finnas i ett land.
Om man däremot har en "Many to many"