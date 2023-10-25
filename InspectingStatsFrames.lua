local name, addon = ...;

-- Function to display the inspected player's stats
function addon:InspectStats()
    if not self then
        addon:CreateFrame()
    else
       --[[  self:Destructor() ]]
        addon:CreateFrame()
    end
end

-- Main Function for setting up the UI
function addon:CreateFrame()
    self:InitFrame()
    self:InitStatsText()
end

function addon:InitFrame()
    local frameSizeX = 150
    local frameSizeY = 120
    local frameSpawnOffsetY = 0
    local frameSpawnOffsetX = 160

    self.frame = CreateFrame("Frame", "MyInspectStatsFrame", InspectPaperDollFrame, 'BasicFrameTemplateWithInset')
    self.frame:SetSize(frameSizeX, frameSizeY)
    self.frame:SetPoint("BOTTOMRIGHT", frameSpawnOffsetX, frameSpawnOffsetY)
    self.frame:SetMovable(true)
    self.frame:SetScript("OnMouseDown",self.frame.StartMoving)
    self.frame:SetScript("OnMouseUp",self.frame.StopMovingOrSizing)

    local closeButton = CreateFrame("Button", nil, self.frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT")
    closeButton:SetScript("OnClick", function(self)
        print('asd')
    end)
end

function addon:InitStatsText()
    local stats = addon.CalculateStats(self)
    local textOffsetY = -10  -- Y offset
    local textOffsetYGap = 20 -- Increments the textOffsetY
    local initialTextOffsetY = -25 -- The list starts from here

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


function addon:Destructor()
    print('Destructor')
    print(self.isInspecting)
    addon.isInspecting = false
    self = nil
end
