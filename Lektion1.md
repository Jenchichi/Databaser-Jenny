## Relationsdatabaser
SQL används Relationsdatabser - kolumnerna i tabellen kallas nycklar. det skall gå fort att slå upp information med en nyckel.
En databas är en samling information som är organiserad för att man enkelt ska kunna söka och ändra enskilda delar av informationen.
En databas hanterare (DMBS) är den mjukvara som använda för att söka och manipulera data i en specifik typ av databas.
Det finns olika sorters databaser. Vi kommer fokusera på den kategori av databaser som kallas relationsdatabaser, som är väldigt vanlig.
Relationsdatabaser lagrar data i tabellform, och ofta är det relationerna mellan olika kollumner i tabeller som är det mest intressanta. Därav namnet relationsdatabas.

## SQL
SQL är ett standardiserat programspråk för att hämta och modifiera data i relationsdatabaser (RDBMS)
Olika databashanterare (tex. Oracle, Postgres och MYSQL) använder olika dialekter av SQL. Variationerna är dock oftast relativt små. Oracle är den som har mest "fel", stora myndigheter använder oftast oracle.
I denna och kommande lektioner använder vi T-SQL som är den variant som Microsoft använder i sin SQL-server. Prestandan är bra och det går väldigt fort. En databas som inte administreras rätt är långsam.

## Queries
För att hämta ut eller ändra information i en relationsdatabas skickar man så kallade queries (frågor) till databashanteraren (servern).
En query kan vara allt från väldigt simpel ("ge mig all data i tabell xyz") till väldigt komplex (tex korsrefererera data från flera tabeller med en mängd villkor för exakt data som man vill få ut).

## SELECT
När man vill hämta och visa data från en tabell använder vi "SELECT":
Syntax: SELECT (lista med) kolumnnamn FROM tabellnamn

SELECT id, username, password FROM users;

För att ta ut alla kolumner i en tabell kan man skriva: SELECT* FROM tabellnamn;

## TOP x *
Man vill i princip aldrig be om all data i en tabell (SELECT*) då tex tabellen "users" kan innehålla tusentals användare.

ENDAST i Microsoft SQL: SELECT TOP 10* FROM USERS;

## WHERE
Ett annat sätt att begrända är att bara be om rader som matchar ett givet villkor. Detta gör man med "WHERE".
SELECT* FROM USERS WHERE usernames is isabelle*;

## or och in
Använd in ist för or 
SELECT* countries in ("Sweden", "Norway", "Denmark") #Gör en lista istället för massa or.

## Order by
Man kan välja att sortera resultatet på en eller flera kolumner.
select * from people order by lastname, firstname;

## Distinct
Om man vill bara ha ut unika värden så kan man använda "distinct".
Select distinct country from cities;

## Aliases
Aliases används för att i sin query referar till tex. kolumner eller tabeller med ett annat namn än de har i databasen. Detta kan vara användbart tex. för att slippa skriva så mycket, eller att man vill att resultatet skall visas med ett annat namn.

## Union all
Ibland vill man slå ihop resultatet från två (eller fler) queries till ett enda. Det kan man göra med "union all" förutsatt att kolumnera i de olika frågorna matchar:
Om man bara använder #union" iställer för "union all" så elimineras alla dubbletter.

## Case when
Med konstruktion case-when kan man välja att visa olika värden i resultatet beroende på vilkor man angett (som utvärders per rad).

## SQL är mer än bara select-satser
Man kan göra mycket mer med SQL än att bara plocka ut dataa från tabeller som vi gjort i exemplen ovan.
