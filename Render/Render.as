void RenderMenu() {
    if(UI::BeginMenu(pluginMenuTitle)) {
        if(windowVisible) {
            if(UI::MenuItem("Hide")) {
                windowVisible = false;
            }
            if(UI::MenuItem("Force refresh")) {
                ForceRefresh();
            }
        } else {
            if(UI::MenuItem("Show")) {
                windowVisible = true;
            }
        }

        UI::EndMenu();
    }
}

// ############################## WINDOW RENDER #############################

void Render() {

    if(displayMode == EnumDisplayMode::ALWAYS) {
        RenderWindows();
    } else if (UI::IsGameUIVisible() && displayMode == EnumDisplayMode::ALWAYS_EXCEPT_IF_HIDDEN_INTERFACE){
        RenderWindows();
    }

    if(displayMode == EnumDisplayMode::HIDE_WHEN_DRIVING){
        auto state = VehicleState::ViewingPlayerState();
        if(state is null) return;
        float currentSpeed = state.WorldVel.Length() * 3.6;
        if(currentSpeed >= hiddingSpeedSetting) return;

        RenderWindows();
    }
    
    
}

void RenderInterface(){
    if(displayMode == EnumDisplayMode::ONLY_IF_OPENPLANET_MENU_IS_OPEN) {
        RenderWindows();
    }
}


void RenderWindows(){
    auto app = cast<CTrackMania>(GetApp());
   
    int windowFlags = UI::WindowFlags::NoTitleBar | UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoDocking | UI::WindowFlags::NoFocusOnAppearing;

    if (!UI::IsOverlayShown()) {
        windowFlags |= UI::WindowFlags::NoInputs;
    }

    //we don't want to show the window if we're in the editor
    if(app.Editor !is null){
        return;
    }
        

    if(windowVisible && app.CurrentPlayground !is null){
        UI::Begin(pluginName, windowFlags);

        UI::BeginGroup();

        UI::Text(pluginMenuTitle);
        UI::Separator();

        UI::EndGroup();
        UI::BeginGroup();
        
        if (contenders.zoneNames.Length > 0 && contenders.zoneContenders.Length > 0) {
            for(uint i = 0; i<contenders.zoneNames.Length; i++) {
                UI::Text(contenders.zoneNames[i]+" : "+contenders.zoneContenders[i]);
            }
        }
        

        UI::EndGroup();

        UI::End();
    }
}
