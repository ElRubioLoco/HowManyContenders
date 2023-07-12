void Main(){
#if TMNEXT

    auto app = cast<CTrackMania>(GetApp());
    auto network = cast<CTrackManiaNetwork>(app.Network);

    while(true){

        //if we're on a new map, the timer is over or a new pb has been made we update the times
        if(refreshContenders){
            if(CanRefresh()){
                mapid = network.ClientManiaAppPlayground.Playground.Map.MapInfo.MapUid;
                if(MapHasNadeoLeaderboard(mapid)){
                    validMap = true;
                    contenders.updateValues();
                }else{
                    validMap = false;
                    contenders.resetContendersCount();
                }
                refreshContenders = false;
            }
        }
        yield();

    }

#endif
}

/**
 * Checks if we are in a position to refresh the times or not
 */
bool CanRefresh(){
    auto app = cast<CTrackMania>(GetApp());
    auto network = cast<CTrackManiaNetwork>(app.Network);

    //check that we're in a map
    if (network.ClientManiaAppPlayground is null || network.ClientManiaAppPlayground.Playground is null || network.ClientManiaAppPlayground.Playground.Map is null){
        return false;
    }
    
    // check that we're not in an invalid gamemode
    auto ServerInfo = cast<CTrackManiaNetworkServerInfo>(network.ServerInfo);
    string gamemode = ServerInfo.CurGameModeStr;

    if(invalidGamemodes.Find(gamemode) != -1){
        return false;
    }

    //we don't want to update the times if we know the current refresh has already failed.
    //This should not deadlock because other parts of the plugin will be able to unlock this
    if(failedRefresh){
        return false;
    }

    return true;
}