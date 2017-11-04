defmodule Alerts do
  @moduledoc """
  Documentation for Alerts.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Alerts.hello
      :world

  """
  def hello do
    :world
  end

  def get_alerts(attr) do
    resp = HTTPoison.get!("http://realtime.mbta.com/developer/api/v2/alerts?api_key=wX9NwuHnZU2ToO7GmGR9uw&include_access_alerts=true&include_service_alerts=true&format=json")
    data = Poison.decode!(resp.body)
    xs = data["alerts"]
    Enum.map xs, fn x ->
      x["#{attr}"]
    end
  end
end
