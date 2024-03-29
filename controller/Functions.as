void waitForAuthentication() {
    if (!UserCanUseThePlugin()) {
        print("Waiting 30 more seconds for permissions...");
        while (timerStartDelay > 0) {
            yield();
        }
        if (!UserCanUseThePlugin()) {
            warn("You currently don't have the permissions to use this plugin, you at least need the standard edition");
            warn("If you do have the permissions, the plugin checks every 30 seconds and should work when you finished loading into the main menu");
            timerStartDelay = 30 * 1000;
            while (true) {
                yield();
                if (timerStartDelay < 0) {
                    if (UserCanUseThePlugin()) {
                        break;
                    }
                    timerStartDelay = 30 * 1000;
                }
            }
        }
        print("Permission granted!");
    }
    startupEnded = true;
    // Ajouter les audiences nécessaires
    NadeoServices::AddAudience("NadeoLiveServices");
 
    // Attendre que les services soient authentifiés
    while (!NadeoServices::IsAuthenticated("NadeoLiveServices")) {
        yield();
    }
}

bool MapHasNadeoLeaderboard(const string &in mapid) {
    Json::Value info = FetchEndpoint(NadeoServices::BaseURLLive() + "/api/token/map/" + mapid);

    return info.GetType() == Json::Type::Object;
}

bool mapidIsValid(const string &in mapid) {
    return true;
    // À implémenter.
}

/**
 * Fetch an endpoint from the Nadeo Live Services
 * 
 * Needs to be called from a yieldable function
 */
Json::Value FetchEndpoint(const string &in route) {
    while (!NadeoServices::IsAuthenticated("NadeoLiveServices")) {
        yield();
    }
    auto req = NadeoServices::Get("NadeoLiveServices", route);
    req.Start();
    while(!req.Finished()) {
        yield();
    }
    return Json::Parse(req.String());
}

Json::Value PostRequest(const string &in route, const string &in requestBody) {
    while (!NadeoServices::IsAuthenticated("NadeoLiveServices")) {
        yield();
    }
    auto req = NadeoServices::Post("NadeoLiveServices", route, requestBody);
    req.Start();
    while(!req.Finished()) {
        yield();
    }
    return Json::Parse(req.String());
}

/**
 * Check if the user can use the plugin or not, based on different conditions
 */
bool UserCanUseThePlugin(){
    //Since this plugin request the leaderboard, we need to check if the user's current subscription has those permissions
    return (Permissions::ViewRecords());
}


/**
 * Force a refresh of the leaderboard ( requested by the user )
 * also remove the "failed request" lock
 */
void ForceRefresh(){
    failedRefresh = false;
    counterTries = 0;
    if(!refreshContenders){
            refreshContenders = true;
    }
}

void Update(float dt) {

    auto app = cast<CTrackMania>(GetApp());
    auto network = cast<CTrackManiaNetwork>(app.Network);
    
    //check if we're in a map
    if(app.CurrentPlayground !is null && network.ClientManiaAppPlayground !is null && network.ClientManiaAppPlayground.Playground !is null && network.ClientManiaAppPlayground.Playground.Map !is null){
        if(currentMapUid != app.RootMap.MapInfo.MapUid) {
            refreshContenders = true;
            currentMapUid = app.RootMap.MapInfo.MapUid; 
            print("New map, refreshing HMC...");
            //get the user id
            
        }
    }
}

CTrackManiaPlayerInfo@ getPlayerInfos() {
    return cast<CTrackManiaNetwork>(cast<CTrackMania>(GetApp()).Network).PlayerInfo;
}
