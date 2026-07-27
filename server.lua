local function trim(value)
    if not value then return nil end
    return (value:gsub("^%s*(.-)%s*$", "%1"))
end

lib.callback.register('qbox-vehicletransfer:transferVehicle', function(source, targetId, plate)
    local src = source
    local target = targetId
    
    local xPlayer = exports.qbx_core:GetPlayer(src)
    local targetPlayer = exports.qbx_core:GetPlayer(target)
    
    if not xPlayer then return false, "Araç devir işlemi başarısız: Kendi karakter verilerine ulaşılamadı." end
    
    if not targetPlayer then 
        return false, "Hatalı ID: Belirtilen ID'ye sahip oyuncu bulunamadı." 
    end

    if xPlayer.PlayerData.citizenid == targetPlayer.PlayerData.citizenid then
        return false, "Araç devir işlemi başarısız: Kendine araç devredemezsin!"
    end

    -- Satıcının araç kontrolü
    local ped = GetPlayerPed(src)
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        return false, "Araç devir işlemi başarısız: Herhangi bir aracın içinde değilsin!"
    end

    -- Alıcının araç kontrolü
    local targetPed = GetPlayerPed(target)
    local targetVehicle = GetVehiclePedIsIn(targetPed, false)

    if targetVehicle == 0 then
        return false, "Araç devir işlemi başarısız: Alıcı oyuncu herhangi bir aracın içinde değil!"
    end

    -- İki oyuncunun da AYNI araçta olup olmadığını kontrol et
    if vehicle ~= targetVehicle then
        return false, "Araç devir işlemi başarısız: Devredeceğiniz kişi ile aynı araçta olmalısınız!"
    end

    local currentPlate = trim(GetVehicleNumberPlateText(vehicle))
    if currentPlate ~= trim(plate) then
        return false, "Araç devir işlemi başarısız: İşlem sırasında plaka uyuşmazlığı tespit edildi!"
    end

    local result = MySQL.query.await('SELECT citizenid FROM player_vehicles WHERE plate = ?', {currentPlate})

    if not result or #result == 0 then
        return false, "Araç devir işlemi başarısız: Bu araç veritabanında kayıtlı değil!"
    end

    local vehicleOwner = result[1].citizenid

    if vehicleOwner == xPlayer.PlayerData.citizenid then
        MySQL.update('UPDATE player_vehicles SET citizenid = ? WHERE plate = ?', {targetPlayer.PlayerData.citizenid, currentPlate})
        
        TriggerClientEvent('ox_lib:notify', target, { 
            title = 'Araç Devir İşlemi', 
            description = string.format('%s isimli kişiden bir araç devraldın! Plaka: %s', xPlayer.PlayerData.charinfo.firstname, currentPlate), 
            type = 'success' 
        })

        return true, string.format('Araç devir işlemi başarılı: %s plakalı aracı başarıyla devrettin.', currentPlate)
    else
        return false, "Araç devir işlemi başarısız: Bu aracın resmi sahibi sen değilsin, başkasının aracını devredemezsin!"
    end
end)