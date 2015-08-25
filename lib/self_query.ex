defmodule SelfQuery do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @app_module __MODULE__ |> Module.split |> List.first |> String.to_atom
      @struct __MODULE__ |> Module.split |> List.last |> String.to_atom

      def all do
        @app_module.Repo.all(__MODULE__)
      end

      def get(id, opts \\ []) do
        @app_module.Repo.get(__MODULE__, id, opts)
      end

      def get!(id, opts \\ []) do
        @app_module.Repo.get!(__MODULE__, id, opts)
      end

      def get_by(id, opts \\ []) do
        @app_module.Repo.get_by(__MODULE__, id, opts)
      end

      def get_by!(id, opts \\ []) do
        @app_module.Repo.get_by!(__MODULE__, id, opts)
      end

      def one(id, opts \\ []) do
        @app_module.Repo.one(__MODULE__, id, opts)
      end

      def one!(id, opts \\ []) do
        @app_module.Repo.one!(__MODULE__, id, opts)
      end

      def update_all(id, opts \\ []) do
        @app_module.Repo.update_all(__MODULE__, id, opts)
      end

      def delete_all(id, opts \\ []) do
        @app_module.Repo.delete_all(__MODULE__, id, opts)
      end

      defoverridable [
        all: 0,
        get: 1,
        get: 2,
        get!: 1,
        get!: 2,
        get_by: 1,
        get_by: 2,
        get_by!: 1,
        get_by!: 2,
        one: 1,
        one: 2,
        one!: 1,
        one!: 2,
        update_all: 1,
        update_all: 2,
        delete_all: 1,
        delete_all: 2
      ]
    end
  end
end
