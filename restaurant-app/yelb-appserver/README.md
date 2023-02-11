This is the application server. It's a Ruby/Sinatra application that exposes a number of APIs that are consumed by the UI (or via curl if you fancy that). 
p';kj'l'lk'jlk/mn,nmbv,m
Originally this application was included in a single file (`yelb-appserver.rb`). This has been since refactored by extracting the single API definition in their separate adapters and modules. This made the transition to Lambda/Serverless easier (one lambda per API definition). This hasn't changed the other deplo
