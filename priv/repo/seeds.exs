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

alias ChampionsOfMirra.Characters.Character
alias ChampionsOfMirra.Repo
Repo.insert!(Character.changeset(%Character{}, %{name: "muflus"}))
Repo.insert!(Character.changeset(%Character{}, %{name: "h4ck"}))
Repo.insert!(Character.changeset(%Character{}, %{name: "uma"}))
Repo.insert!(Character.changeset(%Character{}, %{name: "valtimer"}))
Repo.insert!(Character.changeset(%Character{}, %{name: "otix"}))
Repo.insert!(Character.changeset(%Character{}, %{name: "kenzu"}))
Repo.insert!(Character.changeset(%Character{}, %{name: "uren"}))
Repo.insert!(Character.changeset(%Character{}, %{name: "d'agna"}))

{:ok, user1} = ChampionsOfMirra.Accounts.register_user %{email: "faker@t1.com", username: "Faker", password: "fakerfakerfaker"}
{:ok, user2} = ChampionsOfMirra.Accounts.register_user %{email: "doinb@fpx.com", username: "Doinb", password: "doinbdoinbdoinb"}
user_1_id = user1.id
user_2_id = user2.id
ChampionsOfMirra.Units.insert_unit(%{
  level: 4,
  selected: true,
  position: 1,
  user_id: user_1_id,
  character_id: ChampionsOfMirra.Characters.get_character_by_name("muflus").id
})
ChampionsOfMirra.Units.insert_unit(%{
  level: 3,
  selected: true,
  position: 2,
  user_id: user_1_id,
  character_id: ChampionsOfMirra.Characters.get_character_by_name("h4ck").id
})
ChampionsOfMirra.Units.insert_unit(%{
  level: 2,
  selected: true,
  position: 3,
  user_id: user_1_id,
  character_id: ChampionsOfMirra.Characters.get_character_by_name("uma").id
})
ChampionsOfMirra.Units.insert_unit(%{
  level: 1,
  selected: true,
  position: 1,
  user_id: user_2_id,
  character_id: ChampionsOfMirra.Characters.get_character_by_name("h4ck").id
})
ChampionsOfMirra.Units.insert_unit(%{
  level: 1,
  selected: true,
  position: 2,
  user_id: user_2_id,
  character_id: ChampionsOfMirra.Characters.get_character_by_name("valtimer").id
})
ChampionsOfMirra.Units.insert_unit(%{
  level: 2,
  selected: true,
  position: 3,
  user_id: user_2_id,
  character_id: ChampionsOfMirra.Characters.get_character_by_name("muflus").id
})
