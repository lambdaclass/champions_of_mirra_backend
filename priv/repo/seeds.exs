# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ChampionsOfMirra.Repo.insert!(%ChampionsOfMirra.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ChampionsOfMirra.Characters
alias ChampionsOfMirra.Units
alias ChampionsOfMirra.Campaigns
alias ChampionsOfMirra.Accounts

character_names = [
  "muflus",
  "h4ck",
  "uma",
  "valtimer",
  "otix",
  "kenzu",
  "uren",
  "dagna"
]

level_names = [
  "Shadows' Veil Confrontation",
  "Enigma of the Cursed Mists",
  "Infernal Eclipse Skirmish",
  "Celestial Citadel Clash",
  "Whispering Abyss Showdown",
  "Radiant Fury Rampart",
  "Vortex of Eternal Strife",
  "Luminous Desolation Duel",
  "Mystic Tides Turmoil",
  "Abyssal Dominion Decisive"
]

### Characters

characters = Enum.map(character_names, fn name ->
  {:ok, character} = Characters.insert_character(%{name: name})
  character
end)
[muflus, h4ck, uma, valtimer, _otix, _kenzu, _uren, _dagna] = characters

### Users

{:ok, user_1} =
  Accounts.register_user(%{email: "faker@t1.com", username: "Faker", password: "fakerfakerfaker"})

{:ok, user_2} =
  Accounts.register_user(%{email: "doinb@fpx.com", username: "Doinb", password: "doinbdoinbdoinb"})

### Units

## User 1

{:ok, _} = Units.insert_unit(%{
  level: 4,
  selected: true,
  slot: 1,
  user_id: user_1.id,
  character_id: muflus.id
})

{:ok, _} = Units.insert_unit(%{
  level: 3,
  selected: true,
  slot: 2,
  user_id: user_1.id,
  character_id: h4ck.id
})

{:ok, _} = Units.insert_unit(%{
  level: 2,
  selected: true,
  slot: 3,
  user_id: user_1.id,
  character_id: uma.id
})

# User 2

{:ok, _} = Units.insert_unit(%{
  level: 1,
  selected: true,
  slot: 1,
  user_id: user_2.id,
  character_id: h4ck.id
})

{:ok, _} = Units.insert_unit(%{
  level: 1,
  selected: true,
  slot: 2,
  user_id: user_2.id,
  character_id: valtimer.id
})

{:ok, _} = Units.insert_unit(%{
  level: 2,
  selected: true,
  slot: 3,
  user_id: user_2.id,
  character_id: muflus.id
})

### Campaigns

{:ok, _campaign} = Campaigns.insert_campaign(%{
  name: "Great Kaline War",
  number: 1,
  levels: level_names |> Enum.with_index() |> Enum.map(fn {name, number} ->
    %{
      name: name,
      number: number,
      units: Enum.map(1..5, & %{
        level: Enum.random(min(1, number - 1)..number + 1),
        selected: true,
        slot: &1,
        character_id: Enum.random(characters).id
        })
    }
  end)
})
