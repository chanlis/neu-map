# Alerts
The purpose of this experiment is to determine if the appropriate alert headers, severity, and station information can be determined using the MBTA API.

## Running the Experiment
Clone this experiment, run the elixir shell with `iex -S mix` and execute the following commands...
  * alert headers - `Alerts.get_alerts("header_text")`
  * alert severity - `Alerts.get_alerts("severity")`
  * alert affected_services - `Alerts.get_alerts("affected_services")`
