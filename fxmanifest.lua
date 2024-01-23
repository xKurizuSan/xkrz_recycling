fx_version 'cerulean'
game 'gta5'

author 'xKurizu'
description 'Recycling for ESX and QBCORE'
version '1.1.0'

shared_scripts {
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
