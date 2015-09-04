defmodule PlanningPoker.BrowserCaseHelper do
  defmacro __using__(_opts) do
    quote do
      import PlanningPoker.BrowserCaseHelper
    end
  end

  use TucoTuco.DSL

  def input_value(id) do
    element = TucoTuco.Retry.retry fn ->
      Finder.find(:id, id)
    end

    case element do
      nil ->
        screenshot!
        nil
      ele ->
        ele |> Element.attribute(:value)
    end
  end

  def screenshot! do
    name = :crypto.strong_rand_bytes(5) |> :base64.encode_to_string
    save_screenshot "#{name}.png"
  end

  def wait(ms) do
    :timer.sleep(ms)
  end
end
