// ################
// ### Settings ###
// ################

[Setting category="Display Settings" name="Window visible" description="To move the windows, click and drag while the Openplanet overlay is visible."]
bool windowVisible = true;

[Setting category="Display Settings" name="Display mode" description="When should the overlay be displayed?"]
EnumDisplayMode displayMode = EnumDisplayMode::ALWAYS;

[Setting hidden name="Refresh timer (minutes)" description="The amount of time between automatic refreshes of the leaderboard. Must be over 0." min=1]
int refreshTimer = 5;

[Setting hidden]
float hiddingSpeedSetting = 1.0f;
