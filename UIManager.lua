local AN, ANS = ...;
UIManager = {}

function UIManager:New()
    local newInstance = {}
    setmetatable(newInstance, self)
    self.__index = self
    return newInstance
end

function UIManager:ShowStats()
    self:InitFrame()
    self:InitStatsText()
end

function UIManager:InitFrame()
    local frameSizeX = 150
    local frameSizeY = 120
    local frameSpawnOffsetY = 0
    local frameSpawnOffsetX = 160

    -- Frame 
    self.frame = CreateFrame("Frame", "MyInspectStatsFrame", InspectPaperDollFrame, 'BasicFrameTemplateWithInset')
    self.frame:SetSize(frameSizeX, frameSizeY)
    self.frame:SetPoint("BOTTOMRIGHT", frameSpawnOffsetX, frameSpawnOffsetY)
    self.frame:SetMovable(true)
    self.frame:SetScript("OnMouseDown", self.frame.StartMoving)
    self.frame:SetScript("OnMouseUp", self.frame.StopMovingOrSizing)

    -- Close Button
    local closeButton = CreateFrame("Button", nil, self.frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT")
    closeButton:SetScript("OnHide", function()
        self:HandleCloseStatsWindow()
    end)
end

function UIManager:InitStatsText()
    local stats = StatManager:CalculateStats(ANS.currentInspectUnitName) -- Fetch stats from the StatManager
    local textOffsetY = -10
    local textOffsetYGap = 20
    local initialTextOffsetY = -25

    -- Define a table of stat labels and their names
    local statLabels = {
        { name = "Crit", label = "Crit" },
        { name = "Haste", label = "Haste" },
        { name = "Mastery", label = "Mastery" },
        { name = "Vers", label = "Versatility" },
    }

    -- Create text label for target name
    local labelTargetName = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    labelTargetName:SetPoint("TOP", 0, -5)
    labelTargetName:SetText(stats.targetName)

    -- Create text labels to display stats
    for _, stat in ipairs(statLabels) do
        local label = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        label:SetPoint("TOPLEFT", self.frame, 15, initialTextOffsetY + textOffsetY)
        label:SetText(stat.label .. ": " .. (stats[stat.name] or 0))
        textOffsetY = textOffsetY - textOffsetYGap
    end
end

function UIManager:HandleCloseStatsWindow()
    ANS.inspectInProgress = false
    ANS.currentInspectUnitName = nil
end