-- Version du fichier 1.0

fx_version "adamant"
games {"gta5"}

version '1.0.0'
author 'Akiyo'
description 'Simple Fivem script for cut power, Create for WanhAki (https://discord.gg/tKJGHadsVX)'
repository 'https://github.com/Akiyo-bot/ak1-radio'


client_scripts {
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/elements/*.lua",
    "RageUI/menu/items/*.lua",
    "RageUI/menu/panels/*.lua",
    "RageUI/menu/windows/*.lua",
}

client_scripts {
	'config.lua',
    "client/*.lua",
	'locales/*.lua',
}

server_scripts {
	'config.lua',
    "server/*.lua",
	'locales/*.lua',
}

dependencies {
	"pma-voice",
}