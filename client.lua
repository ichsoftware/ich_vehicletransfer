local function trim(value)
    if not value then return nil end
    return (value:gsub("^%s*(.-)%s*$", "%1"))
end

RegisterCommand('aracdevret', function(source, args)
    local playerId = tonumber(args[1])
    if not playerId then
        lib.notify({ title = 'Araç Devir İşlemi', description = 'Kullanım: /aracdevret [OyuncuID]', type = 'error' })
        return
    end

    local ped = PlayerPedId()
    
    if not IsPedInAnyVehicle(ped, false) then
        lib.notify({ title = 'Araç Devir İşlemi', description = 'Devretmek istediğin aracın içinde olmalısın!', type = 'error' })
        return
    end

    local vehicle = GetVehiclePedIsIn(ped, false)
    local plate = trim(GetVehicleNumberPlateText(vehicle))

    lib.callback('qbox-vehicletransfer:transferVehicle', false, function(success, message)
        if success then
            lib.notify({ title = 'Araç Devir İşlemi', description = message, type = 'success' })
        else
            lib.notify({ title = 'Araç Devir İşlemi', description = message, type = 'error' })
        end
    end, playerId, plate)
end, false)