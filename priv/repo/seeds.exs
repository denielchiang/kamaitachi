# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Kamaitachi.Repo.insert!(%Kamaitachi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Kamaitachi.Repo.insert!(%Kamaitachi.Accounts.User{
  name: "Den",
  email: "deniel@jay-creative.com",
  password_hash: Bcrypt.hash_pwd_salt("12345678Ab")
})
