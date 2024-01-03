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

characters =
  Enum.map(character_names, fn name ->
    {:ok, character} = Characters.insert_character(%{name: name})
    character
  end)

[muflus, h4ck, uma, valtimer, _otix, _kenzu, _uren, _dagna] = characters

### Users

{:ok, user_1} =
  Accounts.register_user(%{
    email: "user1@mail.com",
    username: "user1",
    password: "useruseruser",
    device_client_id: "user1"
  })

{:ok, user_2} =
  Accounts.register_user(%{
    email: "user2@mail.com",
    username: "user2",
    password: "useruseruser",
    device_client_id: "user2"
  })

### Units

user_1_units =
  Enum.map(
    1..6,
    &Units.insert_unit(%{
      level: Enum.random(1..5),
      selected: true,
      slot: &1,
      character_id: Enum.random(characters).id,
      user_id: user_1.id
    })
  )

user_2_units =
  Enum.map(
    1..6,
    &Units.insert_unit(%{
      level: Enum.random(1..5),
      selected: true,
      slot: &1,
      character_id: Enum.random(characters).id,
      user_id: user_2.id
    })
  )

Enum.all?(user_1_units, fn
  {:ok, _unit} -> true
  _ -> false
end)

Enum.all?(user_2_units, fn
  {:ok, _unit} -> true
  _ -> false
end)

### Campaigns

{:ok, campaign} =
  Campaigns.insert_campaign(%{
    name: "Great Kaline War",
    number: 1,
    levels:
      level_names
      |> Enum.with_index()
      |> Enum.map(fn {name, number} ->
        %{
          name: name,
          number: number,
          units:
            Enum.map(
              1..6,
              &%{
                level: Enum.random(min(1, number - 1)..(number + 1)),
                selected: true,
                slot: &1,
                character_id: Enum.random(characters).id
              }
            )
        }
      end)
  })

{:ok, _} = Campaigns.insert_campaign_unlocked(%{user_id: user_1.id, campaign_id: campaign.id})
