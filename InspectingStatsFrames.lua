AN, ANS = ...;

local MyInspectButton = CreateFrame("Button", "MyInspectButton", InspectPaperDollFrame, "UIPanelButtonTemplate")
MyInspectButton:SetSize(100, 30)
MyInspectButton:SetText("Inspect Stats")
MyInspectButton:SetPoint("LEFT", InspectPaperDollFrame, 0, 0)
MyInspectButton:Hide() -- Hide the button initially

MyInspectButton:SetScript("OnClick", function(self)
    -- Handle button click event
    print("My Button Clicked!")
end)

local frame = CreateFrame("Frame")
frame:RegisterEvent("INSPECT_READY")

frame:SetScript("OnEvent", function(self, event, unitID)
    if event == "INSPECT_READY" then
        MyInspectButton:Show() -- Show the button when inspection is ready
    end
end)

-- Function to display the inspected player's stats
function ANS:IS_InspectStats()
    if not self.frame then
        ANS:IS_CreateFrame()
    else
        self:Destructor()
        ANS:IS_CreateFrame()
    end
end

-- Main Function for setting up the UI
function ANS:IS_CreateFrame()
    self:InitFrame()
    self:InitFrameButtons()
    self:InitStatsText()
end

function ANS:InitFrame()
    self.frame = CreateFrame("Frame", "MyInspectStatsFrame", UIParent, 'BasicFrameTemplateWithInset')
    self.frame:SetSize(150, 120)
    self.frame:SetPoint("CENTER", 0, 0)
    self.frame:SetMovable(true)
    self.frame:SetScript("OnMouseDown",self.frame.StartMoving)
    self.frame:SetScript("OnMouseUp",self.frame.StopMovingOrSizing)
end

function ANS:InitFrameButtons()
    local closeButton = CreateFrame("Button", nil, self.frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT")
    closeButton:SetScript("OnClick", function(self)
        self:Destructor()
    end)
end

function ANS:InitStatsText()
    local stats = ANS.CalculateStats(self)

    -- Create text label for target name
    local labelTargetName = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    labelTargetName:SetPoint("TOP", 0, -5)
    labelTargetName:SetText(stats.targetName)

    -- Create text labels to display stats
    local labelCrit = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    labelCrit:SetPoint("TOPLEFT", 10, -30)
    labelCrit:SetText("Crit: " .. (stats.Crit or 0))

    local labelHaste = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    labelHaste:SetPoint("TOPLEFT", 10, -50)
    labelHaste:SetText("Haste: " .. (stats.Haste or 0))

    local labelMastery = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    labelMastery:SetPoint("TOPLEFT", 10, -70)
    labelMastery:SetText("Mastery: " .. (stats.Mastery or 0))

    local labelVers = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    labelVers:SetPoint("TOPLEFT", 10, -90)
    labelVers:SetText("Versatility: " .. (stats.Vers or 0))
end

function ANS:Destructor()
    self = nil
end
