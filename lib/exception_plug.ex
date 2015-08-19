defmodule ExceptionPlug do
  defmacro __using__(_env) do
    quote location: :keep do
      @before_compile ExceptionPlug
    end
  end

  defmacro __before_compile__(_env) do
    quote location: :keep do
      defoverridable [call: 2]

      def call(conn, opts) do
        try do
          super(conn, opts)
        rescue
          exception ->
            stacktrace = System.stacktrace
            session = Map.get(conn.private, :plug_session)


            Airbrake.report(exception, [
              params: conn.params,
              session: session
            ])

            Rollbax.report(exception, stacktrace)

            reraise exception, stacktrace
        end
      end

    end
  end
end
