fx_version 'cerulean'
game 'gta5'

author 'xKurizu'
description 'ESX Recycling'
version '1.1.0'

shared_scripts {
  '@es_extended/imports.lua',
  '@ox_lib/init.lua',
  'config.lua'
}

client_script {
  'client/client.lua',
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/CircleZone.lua'
}

server_script 'server/server.lua'

lua54 'yes'
