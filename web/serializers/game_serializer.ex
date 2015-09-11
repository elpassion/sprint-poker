defimpl Poison.Encoder, for: SprintPoker.Game do
  alias SprintPoker.Repo
  alias SprintPoker.GameUser

  def encode(game, options) do
    hash =  %{
      id: game.id,
      name: game.name,
      users: [],
      tickets: [],
      owner: %{}
    }

    if Ecto.Association.loaded?(game.owner) do
      hash = hash |> Dict.put(:owner, game.owner)
    end

    if Ecto.Association.loaded?(game.users) do
      users = for user <- game.users, into: [] do
        game_user = Repo.get_by(GameUser, user_id: user.id, game_id: game.id)
        if game_user do
          %{ user | state: game_user.state }
        else
          user
        end
      end

      hash = hash |> Dict.put(:users, users)
    end

    if Ecto.Association.loaded?(game.tickets) do
      tickets = for ticket <- game.tickets, into: %{} do
        {:"#{ticket.id}",  ticket}
      end

      hash = hash |> Dict.put(:tickets, tickets)
    end

    if Ecto.Association.loaded?(game.deck) do
      hash = hash |> Dict.put(:deck, game.deck)
    end

    hash |> Poison.Encoder.encode(options)
  end
end
