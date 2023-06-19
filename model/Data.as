const string pluginName = "How many contenders ?";

bool validMap = false;

int worldContendersCount = 0;

string mapid = "";

float timerStartDelay = 30 *1000; // 30 seconds
bool startupEnded = false;

//variables to check that we aren't currently in a "failed request" (server not responding or not updating the pb) to not spam the server
int counterTries = 0;
int maxTries = 10;
bool failedRefresh = false;

string currentMapUid = "";

float timer = 0;
float updateFrequency = refreshTimer*60*1000; // = minutes * One minute in sec * 1000 milliseconds per second
bool refreshContenders = false;



const array<string> invalidGamemodes = {
    "TM_Royal_Online",
    "TM_RoyalTimeAttack_Online",
    "TM_RoyalValidation_Local"
};
