local AN, ANS = ...;

local frame = CreateFrame("Frame")
frame:RegisterEvent("INSPECT_READY")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("ADDON_LOADED")


local InspectStatsButton = CreateFrame("Button", "MyInspectButton", InspectPaperDollFrame, "UIPanelButtonTemplate")
InspectStatsButton:SetSize(90, 30)
InspectStatsButton:SetText("Show Stats")
InspectStatsButton:SetPoint("LEFT", InspectPaperDollFrame, 150, 0)
InspectStatsButton:Hide()

InspectStatsButton:SetScript("OnClick", function()
    ANS:OnInspect()
end)

frame:SetScript("OnEvent", function(self, event, unitID)
    if event == "INSPECT_READY" then
        if not ANS.inspectInProgress then
            InspectStatsButton:Show()
        end
    elseif event == "PLAYER_TARGET_CHANGED" then
        InspectStatsButton:Hide()
        ANS.inspectInProgress = false
        ANS.currentInspectUnitName = nil
    end
end)