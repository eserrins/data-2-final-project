setwd("~/GitHub/Data Class I/data-2-final-project")

misconducts <- lm(misconducts_percap ~ white_pct + african_american_pct + asian_pct + hispanic_pct + bilingual_pct + sped_pct + econ_pct, data = merged)
summary(misconducts)

misconducts_race <- lm(misconducts_percap ~ white_pct + african_american_pct + asian_pct + hispanic_pct, data = merged)
summary(misconducts_race)

misconducts_econ <- lm(misconducts_percap ~ econ_pct, data = merged)
summary(misconducts_econ)

misconducts_sped <- lm(misconducts_percap ~ sped_pct, data = merged)
summary(misconducts_sped)

misconducts_bilingual <- lm(misconducts_percap ~ bilingual_pct, data = merged)
summary(misconducts_bilingual)

misconducts_year <- lm(misconducts_percap ~ year, data = merged)
summary(misconducts_year)

expelled <- lm(expelled_percap ~ white_pct + african_american_pct + asian_pct + hispanic_pct + bilingual_pct + sped_pct + econ_pct, data = merged)
summary(expelled)

expelled_race <- lm(expelled_percap ~ white_pct + african_american_pct + asian_pct + hispanic_pct, data = merged)
summary(expelled_race)

expelled_econ <- lm(expelled_percap ~ econ_pct, data = merged)
summary(expelled_econ)

expelled_sped <- lm(expelled_percap ~ sped_pct, data = merged)
summary(expelled_sped)

expelled_bilingual <- lm(expelled_percap ~ bilingual_pct, data = merged)
summary(expelled_bilingual)

expelled_year <- lm(expelled_percap ~ year, data = merged)
summary(expelled_year)

suspensions <- lm(suspensions_percap ~ white_pct + african_american_pct + asian_pct + hispanic_pct + bilingual_pct + sped_pct + econ_pct, data = merged)
summary(suspensions)

suspensions_race <- lm(suspensions_percap ~ white_pct + african_american_pct + asian_pct + hispanic_pct, data = merged)
summary(suspensions_race)

suspensions_econ <- lm(suspensions_percap ~ econ_pct, data = merged)
summary(suspensions_econ)

suspensions_sped <- lm(suspensions_percap ~ sped_pct, data = merged)
summary(suspensions_sped)

suspensions_bilingual <- lm(suspensions_percap ~ bilingual_pct, data = merged)
summary(suspensions_bilingual)

suspensions_year <- lm(suspensions_percap ~ year, data = merged)
summary(suspensions_year)

summary(lm(bilingual_pct ~ hispanic_pct + asian_pct + white_pct + african_american_pct, data = merged))