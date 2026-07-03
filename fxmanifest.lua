fx_version 'cerulean'
game 'gta5'

name 'gabz-vehicle-spawner'
author 'GabZ Vehicle Spawner'
description 'Vehicle spawner for GabZ vehicle pack'
version '1.0.0'

lua54 'yes'

shared_scripts {
    'config.lua',
    'shared/locale.lua',
}

client_scripts {
    'client/main.lua',
}

server_scripts {
    'server/main.lua',
}

ui_page 'html/index.html'

files {
    'locales/de.json',
    'locales/en.json',
    'html/index.html',
    'html/style.css',
    'html/script.js',
}