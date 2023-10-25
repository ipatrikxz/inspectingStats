local name, addon = ...;

addon.isInspecting = false
local frame = CreateFrame("Frame")
frame:RegisterEvent("INSPECT_READY")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")

local InspectStatsButton = CreateFrame("Button", "MyInspectButton", InspectPaperDollFrame, "UIPanelButtonTemplate")
InspectStatsButton:SetSize(90, 30)
InspectStatsButton:SetText("Show Stats")
InspectStatsButton:SetPoint("LEFT", InspectPaperDollFrame, 150, 0)
InspectStatsButton:Hide() -- Hide the button initially

InspectStatsButton:SetScript("OnClick", function()
    if not addon.isInspecting then
      addon:InitInspectStats()
      addon.isInspecting = true
    end
end)

frame:SetScript("OnEvent", function(self, event, unitID)
    if event == "INSPECT_READY" then
      InspectStatsButton:Show()
    elseif event == "PLAYER_TARGET_CHANGED" then
      InspectStatsButton:Hide()
      addon.isInspecting = false
    end
end)