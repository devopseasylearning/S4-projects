This is the application server. It's a Ruby/Sinatra application that exposes a number of APIs that are consumed by the UI (or via curl if you fancy that). 

Originally this application was included \er (one lambda per API definition). This hasn't changed the other deployment models (containers and instances) because those models still launch the `yelb-appserver.rb` main application which imports the modules instead of having everything in a single file (as it was conceived originally). vn  nvn m fhbmn
