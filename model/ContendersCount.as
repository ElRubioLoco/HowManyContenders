/**
 * Class used to store the data of the number of contenders in a map by zone.
 */
class ContendersCount{

    ContendersCount() {
        resetContendersCount();
    }

    string zoneId = "";
    
    array<string> zoneNames = {"World", "Unknown", "Unknown", "Unknown", "Unknown"};
    array<uint> zoneContenders;

    void resetContendersCount() {
        zoneContenders = {0, 0, 0, 0, 0};
    }

    void updateValues() {
        updateUserZones();
        updateContendersCount();
        
    }

    void updateUserZones() {
        string zonePath = getPlayerInfos().ZonePath;
        zoneNames = zonePath.Split('|');
    }

    void updateContendersCount() {
        int64 maxint = 9223372036854775806;

        auto app = cast<CTrackMania>(GetApp());
        auto network = cast<CTrackManiaNetwork>(app.Network);

        CGameScoreAndLeaderBoardManagerScript@ manager = network.ClientManiaAppPlayground.ScoreMgr;

        if (network.ClientManiaAppPlayground !is null && network.ClientManiaAppPlayground.Playground !is null && network.ClientManiaAppPlayground.Playground.Map !is null) {
            if (!mapidIsValid(mapid)) {
                mapid = network.ClientManiaAppPlayground.Playground.Map.MapInfo.MapUid;
            }
            for (int i = 0; i<zoneContenders.Length;i++) {
                
                zoneContenders[i] = manager.MapLeaderBoard_GetPlayerCount(mapid, "", wstring(zoneNames[i]));
            }
            /*
            
            string requestBody = '{"maps": [{"mapUid": "'+mapid+'","groupUid": "Personal_Best"}]}';

            Json::Value data = PostRequest(NadeoServices::BaseURL() + "/api/token/leaderboard/group/map?scores["+mapid+"]="+maxint, requestBody);
            if (data.GetType() != Json::Type::Null) {
                Json::Value zones = data[0]["zones"];
                 
                if (zones.GetType() == Json::Type::Array){    
                    // Never goes there.
                    print(zones.Length);
                    for (uint i=0; i<zones.Length; i++) {
                        zoneContenders[i] = zones[i]["ranking"]["position"];
                    }
                }
            }

            int playerCount = CGameScoreAndLeaderBoardManagerScript::MapLeaderBoard_GetPlayerCount(mapid, "Player", "");
            print("Hello : "+playerCount);
            #endif*/
            // string request = NadeoServices::BaseURL()+'/api/token/leaderboard/group/Personal_Best/map/'+mapid+'/top?onlyWorld=true&length=10&offset=50'

        }
    }
}