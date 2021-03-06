#
# Storage for users present in a room
#

class UsersData

    attr_accessor :settings
    attr_accessor :users, :view, :settings
    
    # Fetch the users in the room
    def fetch(room_id)
        url = NSURL.URLWithString "#{settings.host}/rooms/#{room_id}.json"
        puts "Requesting #{settings.host}/#{room_id}.json"
        request = ASIHTTPRequest.requestWithURL(url)
        request.setDelegate self
        request.addRequestHeader "X-Talker-Token", value:settings.token
        request.startAsynchronous
    end

    # On success, parse users in the given room
    def requestFinished(request)
        data = JSON.parse(request.responseString)
        @users = data['users']
        puts @users
        view.reloadData
    end
    
    # Just explode if something bad happens
    def requestFailed(request)
        error = request.error
        puts "Error parsing the users API call"
        # should do something better...
    end    
    
    def numberOfRowsInTableView(view)
        @users ? @users.size : 0
    end
    
    def tableView(view, objectValueForTableColumn:column, row:index)
        @users[index]["name"]
    end

end
