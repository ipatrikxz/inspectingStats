local AN, ANS = ...;

ANS.inspectInProgress = false
ANS.currentInspectUnitName = nil

function ANS:Initialize()
    self.statsManager = StatManager:New()
    self.uiManager = UIManager:New()
end

function ANS:OnInspect()
    if not self.inspectInProgress then
        local unitName = UnitName("target")

        if not unitName then
            print("InspectStats: You must inspect a player first.")
            return
        end

        self:Initialize()
        self.currentInspectUnitName = unitName
        self.inspectInProgress = true
        self.uiManager:ShowStatsFrame()
    else
        print('InspectStats: You already inspecting this unit.')
    end
end

local function HandleInspectReady(event, unitID)
    if not ANS.inspectInProgress then
        ANS:OnInspect()
    end
end

local function HandlePlayerTargetChanged(event)
    ANS.inspectInProgress = false
    ANS.currentInspectUnitName = nil
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("INSPECT_READY")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")

frame:SetScript("OnEvent", function(self, event, unitID)
    if event == "INSPECT_READY" then
        HandleInspectReady(event, unitID)
    elseif event == "PLAYER_TARGET_CHANGED" then
        HandlePlayerTargetChanged(event)
    end
end)