
### 📄 **zv-dutylog**


 🚨 zv-dutylog

**zv-dutylog** is an automatic duty status tracker for QBCore-based FiveM servers. It logs when players go **on duty** and **off duty**, and sends detailed, beautifully formatted logs to Discord using webhooks.

Ideal for jobs like `police`, `ambulance`, `mechanic`, `merchant`, and `government`.


 ✅ Features

- 🔄 Auto-detects duty status changes (via `QBCore:Server:OnJobUpdate`)
- 💬 Sends logs to Discord with rich embedded messages
- ⏱️ Calculates duty duration when players go off duty
- ⚙️ Fully configurable features via `config.lua`
- 🛠️ No commands required — everything runs automatically


 🛠 Installation

1. Drop the `zv-dutylog/` folder inside your server's `resources/` directory.
2. Add this line to your `server.cfg`:


ensure zv-dutylog


3. Open `config.lua` and replace the webhook placeholders with your actual Discord webhook URLs.



 ⚙️ Configuration

Edit `config.lua` to control what data gets sent to Discord:

```lua
Config = {}

Config.Webhooks = {
 police = 'YOUR_POLICE_WEBHOOK_URL',
 ambulance = 'YOUR_AMBULANCE_WEBHOOK_URL',
 mechanic = 'YOUR_MECHANIC_WEBHOOK_URL',
 pedagang = 'YOUR_MERCHANT_WEBHOOK_URL',
 pemerintah = 'YOUR_GOVERNMENT_WEBHOOK_URL',
}

Config.WebhookSender = "Duty Tracker"
Config.EmbedColorOnDuty = 3066993    -- Green
Config.EmbedColorOffDuty = 15158332  -- Red
Config.FooterText = "FiveM Duty Logger"

Config.ShowJob = true
Config.ShowGrade = true
Config.ShowDuration = true
Config.ShowLocalTimestamp = true
```



💬 Example Discord Output

 ✅ On Duty

```
🟢 Zevarda Wijaya is now on duty.
Job: police
Grade: sergeant
Local Time: 09 May 2025 20:30:15
```

 ⛔ Off Duty

```
🔴 Zevarda Wijaya has gone off duty.
Job: police
Grade: sergeant
Time on Duty: 27 minutes
Local Time: 09 May 2025 20:57:28
```


 💡 Use Cases

Perfect for roleplay servers needing:

* Clear duty logs for admins
* Transparent shift tracking for public service jobs
* Professional-grade Discord integration

