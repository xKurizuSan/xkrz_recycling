Config = {}

Config.ProgressBar = 'bar'                              -- 2 Möglichkeiten: 'circle' oder 'bar'
Config.Duration = '7000'                                -- Die Dauer von der ProgressBar. 7000 = 7 Sekunden. INFO: 1000 = 1 Sekunde.
Config.Target = false                                   -- Ob ihr das Target System nutzen wollt oder nicht.
Config.UseSkillCheck = true                             -- Ob der Spieler ein SkillCheck machen soll, damit es nicht einfaches "E" Farmen ist.
Config.SkillCheckDifficulty = {'easy', 'easy', 'easy'}  -- Wie Schwer soll der SkillCheck sein? 'easy' oder 'medium' 'hard' . WICHTIG nur bei UseSkillCheck auf true!
Config.SkillCheckKey = {'e'}                            -- Welche Taste soll gedrückt werden?  {'e'} oder  {'1'}, {'2'}, {'3'}, {'4'} oder  {'w'}, {'a'}, {'s'}, {'d'} . WICHTIG nur bei UseSkillCheck auf true!
Config.getMoney = true                                  -- Soll der Spieler Geld bekommen?

Config.MinItem = 2                                      -- Min. Item soll der Spieler bekommen.
Config.MaxItem = 6                                      -- Max. Item soll der Spieler bekommen.
Config.MinMoney = 1                                     -- Min. Geld soll der Spieler bekommen. WICHTIG nur bei Config.getMoney auf true!
Config.MaxMoney = 3                                     -- Max. Geld soll der Spieler bekommen. WICHTIG nur bei Config.getMoney auf true!

Config.Blip = true                                      -- Soll ein Blip auf der Karte angezeigt werden?

Config.Reward = {
    ItemList = {
        "scrapmetal", "plastic", "copper", "glass", "rubber", "aluminum", "iron"
    }
} 