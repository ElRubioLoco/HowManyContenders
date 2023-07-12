const string pluginName = "How many contenders ?";

bool validMap = false;

string mapid = "";

float timerStartDelay = 30 *1000; // 30 seconds
bool startupEnded = false;

//variables to check that we aren't currently in a "failed request" (server not responding or not updating the pb) to not spam the server
int counterTries = 0;
int maxTries = 10;
bool failedRefresh = false;

ContendersCount@ contenders = ContendersCount();

string currentMapUid = "";

float timer = 0;
float updateFrequency = refreshTimer*60*1000; // = minutes * One minute in sec * 1000 milliseconds per second
bool refreshContenders = false;

const CTrackManiaPlayerInfo@ playerInfo = cast<CTrackManiaNetwork>(cast<CTrackMania>(GetApp()).Network).PlayerInfo;

const array<string> invalidGamemodes = {
    "TM_Royal_Online",
    "TM_RoyalTimeAttack_Online",
    "TM_RoyalValidation_Local"
};

const int WORLDINDEX = 4;
const int CONTINENTINDEX = 3;
const int COUNTRYINDEX = 2;
const int REGIONINDEX = 1;
const int DISTRICTINDEX = 0;

const string iconColor = "\\$d44";
const string icon = Icons::Users;