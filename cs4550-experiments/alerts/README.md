# Alerts
The purpose of this experiment is to determine if the appropriate alert headers, severity, and station information can be determined using the MBTA API.

## Running the Experiment
In the elixir shell, `iex -S mix`, run the following commands
  * alert headers - `Alerts.get_alerts("header_text")
  * alert severity - `Alerts.get_alerts("severity")`
  * alert affected_services - `Alerts.get_alerts("affected_services")`
