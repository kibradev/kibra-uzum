ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_illegal:sellDrug')
AddEventHandler('esx_illegal:sellDrug', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config.DrugDealerItems[itemName]
	local xItem = xPlayer.getQuantity(itemName)

	if not price then
		print(('esx_illegal: %s attempted to sell an invalid drug!'):format(xPlayer.identifier))
		return
	end

	if xPlayer.getQuantity(itemName) < amount then
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli yıkanmış üzümünüz yok!'})

		return
	end

	price = ESX.Math.Round(price * amount)
	xPlayer.addMoney(price)
	xPlayer.removeInventoryItem('yikanmisuzum', amount)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = amount..' tane Yıkanmış Üzüm Satarak '..ESX.Math.GroupDigits(price)..'$ kazandınız'})

end)




ESX.RegisterServerCallback('esx_illegal:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
end)
