local QBCore = exports['qb-core']:GetCoreObject()
local dutyTracking = {}
local Config = Config or {}

local function sendWebhook(job, messageType, playerName, jobName, gradeName, dutyStart)
    local webhook = Config.Webhooks[job]
    if not webhook then return end

    local isOnDuty = (messageType == "on")
    local embedColor = isOnDuty and Config.EmbedColorOnDuty or Config.EmbedColorOffDuty
    local fields = {}

    if Config.ShowJob then
        fields[#fields + 1] = { name = "Job", value = jobName, inline = true }
    end

    if Config.ShowGrade then
        fields[#fields + 1] = { name = "Grade", value = gradeName, inline = true }
    end

    if not isOnDuty and Config.ShowDuration and dutyStart then
        local minutes = math.floor((os.time() - dutyStart) / 60)
        fields[#fields + 1] = { name = "Time on Duty", value = minutes .. " minutes", inline = true }
    end

    if Config.ShowLocalTimestamp then
        fields[#fields + 1] = { name = "Local Time", value = os.date("%d %b %Y %H:%M:%S"), inline = false }
    end

    local description = isOnDuty and ("🟢 **%s is now on duty.**"):format(playerName)
                      or ("🔴 **%s has gone off duty.**"):format(playerName)

    PerformHttpRequest(webhook, function() end, 'POST', json.encode({
        username = Config.WebhookSender,
        embeds = {{
            title = isOnDuty and "✅ On Duty" or "⛔ Off Duty",
            description = description,
            color = embedColor,
            fields = fields,
            footer = { text = Config.FooterText },
            timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ')
        }}
    }), { ['Content-Type'] = 'application/json' })
end

AddEventHandler('QBCore:Server:OnJobUpdate', function(src, JobInfo)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    local job = JobInfo.name
    local onDuty = JobInfo.onduty
    local grade = JobInfo.grade.name

    if Config.Webhooks[job] then
        if onDuty then
            dutyTracking[src] = os.time()
            sendWebhook(job, "on", name, job, grade)
        else
            local startTime = dutyTracking[src]
            sendWebhook(job, "off", name, job, grade, startTime)
            dutyTracking[src] = nil
        end
    end
end)
