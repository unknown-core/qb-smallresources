local QBCore = exports['qb-core']:GetCoreObject()

local Webhooks = {
    ['default'] = GetConvar('default_webhook', ''),
    ['testwebhook'] = GetConvar('testwebhook_webhook', ''),
    ['playermoney'] = GetConvar('playermoney_webhook', ''),
    ['playerinventory'] = GetConvar('playerinventory_webhook', ''),
    ['robbing'] = GetConvar('robbing_webhook', ''),
    ['cuffing'] = GetConvar('cuffing_webhook', ''),
    ['drop'] = GetConvar('drop_webhook', ''),
    ['trunk'] = GetConvar('trunk_webhook', ''),
    ['stash'] = GetConvar('stash_webhook', ''),
    ['glovebox'] = GetConvar('glovebox_webhook', ''),
    ['banking'] = GetConvar('banking_webhook', ''),
    ['vehicleshop'] = GetConvar('vehicleshop_webhook', ''),
    ['vehicleupgrades'] = GetConvar('vehicleupgrades_webhook', ''),
    ['shops'] = GetConvar('shops_webhook', ''),
    ['dealers'] = GetConvar('dealers_webhook', ''),
    ['storerobbery'] = GetConvar('storerobbery_webhook', ''),
    ['bankrobbery'] = GetConvar('bankrobbery_webhook', ''),
    ['powerplants'] = GetConvar('powerplants_webhook', ''),
    ['death'] = GetConvar('death_webhook', ''),
    ['joinleave'] = GetConvar('joinleave_webhook', ''),
    ['ooc'] = GetConvar('ooc_webhook', ''),
    ['report'] = GetConvar('report_webhook', ''),
    ['me'] = GetConvar('me_webhook', ''),
    ['pmelding'] = GetConvar('pmelding_webhook', ''),
    ['112'] = GetConvar('112_webhook', ''),
    ['bans'] = GetConvar('bans_webhook', ''),
    ['anticheat'] = GetConvar('anticheat_webhook', ''),
    ['weather'] = GetConvar('weather_webhook', ''),
    ['moneysafes'] = GetConvar('moneysafes_webhook', ''),
    ['bennys'] = GetConvar('bennys_webhook', ''),
    ['bossmenu'] = GetConvar('bossmenu_webhook', ''),
    ['robbery'] = GetConvar('robbery_webhook', ''),
    ['casino'] = GetConvar('casino_webhook', ''),
    ['traphouse'] = GetConvar('traphouse_webhook', ''),
    ['911'] = GetConvar('911_webhook', ''),
    ['palert'] = GetConvar('palert_webhook', ''),
    ['house'] = GetConvar('house_webhook', ''),
}

local Colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ["lightgreen"] = 65309,
}

RegisterNetEvent('qb-log:server:CreateLog', function(name, title, color, message, tagEveryone)
    local tag = tagEveryone or false
    local webHook = Webhooks[name] or Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Colors[color] or Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = 'Log',
                ['icon_url'] = 'https://media.discordapp.net/attachments/971943172945092650/979708683678269491/incognito3.png?width=482&height=482',
            },
        }
    }
    PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'Log', embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'Log', content = '@everyone'}), { ['Content-Type'] = 'application/json' })
    end
end)

QBCore.Commands.Add('testwebhook', 'Test Your Discord Webhook For Logs (God Only)', {}, false, function()
    TriggerEvent('qb-log:server:CreateLog', 'testwebhook', 'Test Webhook', 'default', 'Webhook setup successfully')
end, 'god')
