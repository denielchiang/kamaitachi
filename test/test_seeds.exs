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
alias Kamaitachi.Repo
alias Kamaitachi.Accounts.User

if !Repo.get_by(User, name: "Den") do
  Repo.insert!(%User{
    name: "Den",
    email: "deniel@jay-creative.com",
    password_hash: Bcrypt.hash_pwd_salt("12345678Ab")
  })
end
