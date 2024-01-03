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

alias ChampionsOfMirra.Accounts
alias ChampionsOfMirra.Campaigns
alias ChampionsOfMirra.Characters
alias ChampionsOfMirra.Gacha
alias ChampionsOfMirra.Units

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

[muflus, h4ck, uma, valtimer, otix, kenzu, uren, dagna] = characters

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
    0..4,
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
    0..4,
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
      |> Enum.with_index(1)
      |> Enum.map(fn {name, number} ->
        %{
          name: name,
          number: number,
          units:
            Enum.map(
              1..6,
              &%{
                level: Enum.random(max(1, number - 1)..(number + 1)),
                selected: true,
                slot: &1,
                character_id: Enum.random(characters).id
              }
            )
        }
      end)
  })

{:ok, _} = Campaigns.insert_campaign_unlocked(%{user_id: user_1.id, campaign_id: campaign.id})
{:ok, _} = Campaigns.insert_level_completed(%{user_id: user_1.id, level_id: hd(campaign.levels).id})

Gacha.insert_box(%{
  name: "Noob box",
  description: "A box for begginers, with only a handful of characters.",
  character_drop_rates: [
    %{
      character_id: muflus.id,
      weight: 1
    },
    %{
      character_id: h4ck.id,
      weight: 1
    },
    %{
      character_id: uma.id,
      weight: 1
    }
  ]
})

Gacha.insert_box(%{
  name: "Premium box",
  description:
    "This box can drop some powerful characters, with a one in a hundred chance to drop the super powerful champion D'Agna!",
  character_drop_rates: [
    %{
      character_id: muflus.id,
      weight: 25
    },
    %{
      character_id: h4ck.id,
      weight: 25
    },
    %{
      character_id: uma.id,
      weight: 10
    },
    %{
      character_id: valtimer.id,
      weight: 10
    },
    %{
      character_id: otix.id,
      weight: 10
    },
    %{
      character_id: kenzu.id,
      weight: 5
    },
    %{
      character_id: uren.id,
      weight: 4
    },
    %{
      character_id: dagna.id,
      weight: 1
    }
  ]
})
