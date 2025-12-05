library(dodgr)

library(DBI)
library(RPostgres)
library(sf)

#file.edit("~/.Renviron")
#dbDisconnect(con)

#Avataan tietokantayhteys (.Renviron)
con <- dbConnect(
  RPostgres::Postgres(),
  host     = Sys.getenv("PG_HOST"),
  port     = as.integer(Sys.getenv("PG_PORT")),
  dbname   = Sys.getenv("PG_DB"),
  user     = Sys.getenv("PG_USER"),
  password = Sys.getenv("PG_PASSWORD"),
  sslmode  = Sys.getenv("PG_SSLMODE") # esim. "require" tuotannossa
)

# Tarkistetaan yhteys
dbIsValid(con)
dbGetQuery(con, "SELECT current_database(), current_user, current_timestamp;")
dbListTables(con)

#Luetaan aineistot tietokannasta
roads <- dbReadTable(con, "digiroad_tielinkin_tyyppi_joensuu")
buil <- dbReadTable(con, "joensuu_buildings_20251029")
