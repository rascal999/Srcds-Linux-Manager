playerProp = {}
currentPlayerPropCount = {}
playerPropCount = {}

seconds = 10
maxProps = 7
banTime = 60
banMessage = "Get out"

function playerSpawnedProp ( ply, model, ent )
	ent:SetOwner( ply:UserID() )
	playerProp[ ply:UserID() ][ currentPlayerPropCount[ ply:UserID() ] + playerPropCount[ ply:UserID() ] ] = ent

	currentPlayerPropCount[ ply:UserID() ] = currentPlayerPropCount[ ply:UserID() ] + 1
--	ply:PrintMessage( HUD_PRINTTALK, currentPlayerPropCount[ ply:UserID() ] )
end

function initialPlayerSpawned( ply )
	currentPlayerPropCount[ ply:UserID() ] = 0
	playerPropCount[ ply:UserID() ] = 0
	playerProp[ ply:UserID() ] = {}
end

function removeProps( ply )
	for i=0,playerPropCount[ ply:UserID() ],1 do
		if ( playerProp[ ply:UserID() ][ i ] != nil ) then
			playerProp[ ply:UserID() ][ i ]:Remove()
		end
	end
	currentPlayerPropCount[ ply:UserID() ] = 0
	playerPropCount[ ply:UserID() ] = 0
	playerProp[ ply:UserID() ] = {}
end

function checkCount( maxProps )
	for k,v in pairs ( player.GetAll() ) do
		playerPropCount[ v:UserID() ] = playerPropCount[ v:UserID() ] + currentPlayerPropCount[ v:UserID() ]
		if ( currentPlayerPropCount[ v:UserID() ] != nil ) then
			if ( currentPlayerPropCount[ v:UserID() ] > maxProps ) then
				removeProps( v )
				v:Ban( banTime, "Prop Spamming" )
				v:Kick( banMessage )
--				v:PrintMessage( HUD_PRINTTALK, "DUH" )
			end
			currentPlayerPropCount[ v:UserID() ] = 0
		end
	end
end

hook.Add( "PlayerSpawnedProp","playerSpawnedProp",playerSpawnedProp )
hook.Add( "PlayerSpawn","playerSpawnedProp",initialPlayerSpawned )

timer.Create("CheckCount", seconds, 0, checkCount, maxProps )
