defimpl Poison.Encoder, for: SprintPoker.Game do
  alias SprintPoker.Repo
  alias SprintPoker.GameUser

  def encode(game, options) do
    hash =  %{
      id: game.id,
      name: game.name,
      users: [],
      tickets: %{},
      owner: %{}
    }

    hash = if Ecto.assoc_loaded?(game.owner) do
      hash |> Map.put(:owner, game.owner)
    else
      hash
    end

    hash = if Ecto.assoc_loaded?(game.users) do
      users = for user <- game.users, into: [] do
        game_user = Repo.get_by(GameUser, user_id: user.id, game_id: game.id)
        if game_user do
          %{user | state: game_user.state}
        else
          user
        end
      end

      hash |> Map.put(:users, users)
    else
      hash
    end

    hash = if Ecto.assoc_loaded?(game.tickets) do
      tickets = for ticket <- game.tickets, into: %{} do
        {:"#{ticket.id}",  ticket}
      end

      hash |> Map.put(:tickets, tickets)
    else
        hash
    end

    hash = if Ecto.assoc_loaded?(game.deck) do
      hash |> Map.put(:deck, game.deck)
    else
      hash
    end

    hash |> Poison.Encoder.encode(options)
  end
end
