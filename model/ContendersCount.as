/**
 * Class used to store the data of the number of contenders in a map by zone.
 */
class ContendersCount{

    ContendersCount() {
        resetContendersCount();
    }

    string zoneId = "";
    
    array<string> zoneNames;
    array<uint> zoneContenders = {};

    void resetContendersCount() {
        zoneContenders = {};
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
    
        if (network.ClientManiaAppPlayground !is null && network.ClientManiaAppPlayground.Playground !is null && network.ClientManiaAppPlayground.Playground.Map !is null) {
            if (!mapidIsValid(mapid)) {
                mapid = network.ClientManiaAppPlayground.Playground.Map.MapInfo.MapUid;
            }

            string requestBody = '{"maps": [{"mapUid": "'+mapid+'","groupUid": "Personal_Best"}]}';

            Json::Value data = PostRequest(NadeoServices::BaseURLLive() + "/api/token/leaderboard/group/map?scores["+mapid+"]="+maxint, requestBody);
            if (data.GetType() != Json::Type::Null) {
                Json::Value zones = data[0]["zones"];
                 
                if (zones.GetType() == Json::Type::Array){   
                    for (uint i=0; i<zones.Length; i++) {
                        
                        int pos = zones[i]["ranking"]["position"];
                        if (pos < 10000) {
                            pos = pos - 1;
                        }
                        zoneContenders.InsertLast(pos);
                    }
                }
            }
        }
    }
}