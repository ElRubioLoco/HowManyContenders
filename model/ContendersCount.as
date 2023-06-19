/**
 * Class used to store the data of the number of contenders in a map by zone.
 */
class ContendersCount{

    ContendersCount() {
        resetContendersCount();
    }

    string zoneId = "";
    
    array<string> zoneNames = {"World", "Unknown", "Unknown", "Unknown", "Unknown"};
    array<int> zoneContenders;

    void resetContendersCount() {
        zoneContenders = {0, 0, 0, 0, 0};
    }

    void updateValues() {
        updateContendersCount();
        updateUserZones();
    }

    void updateUserZones() {
        string zonePath = getPlayerInfos().ZonePath;
        zoneNames = splitString(zonePath,'|');
    }

    void updateContendersCount() {
        auto app = cast<CTrackMania>(GetApp());
        auto network = cast<CTrackManiaNetwork>(app.Network);
    
        if (network.ClientManiaAppPlayground !is null && network.ClientManiaAppPlayground.Playground !is null && network.ClientManiaAppPlayground.Playground.Map !is null) {
            if (!mapidIsValid(mapid)) {
                mapid = network.ClientManiaAppPlayground.Playground.Map.MapInfo.MapUid;
            }

            Json::Value data = FetchEndpoint(NadeoServices::BaseURL() + "/api/token/leaderboard/group/map?scores["+mapid+"]="+maxint);
            if (data.GetType() != Json::Type::Null) {
                Json::Value zones = data["zones"];
                if (zones.GetType() == Json::Type::Array){    
                    for (uint i=0; i<zones.Length; i++) {
                        zoneContenders[i] = zones[i]["ranking"]["position"];
                    }
                }
            }
        }
    }
}