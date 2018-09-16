if getCEVersion() < 6.8 then showMessage('AddressLogger requires CE Version 6.8 or higher to run correctly.') return end


--[[
   BEGIN GUI ELEMENTS
  ]]


local mfrm = getMainForm()
local btnDelAddressList = mfrm.findComponentByName('SpeedButton2')
local btnMemoryView = mfrm.findComponentByName('btnMemoryView')
local sfrm = getSettingsForm()
local tsExtra = sfrm.findComponentByName('Extra')
local cbProcessWatcher = sfrm.findComponentByName('cbProcessWatcher')
local btnOK = sfrm.findComponentByName('btnOK')
local btnOKOnClick = btnOK.OnClick
local loadDialog = createOpenDialog(sfrm)
loadDialog.InitialDir = '0' -- for directory management (see loadCheatTable())

btnDelAddressList.AnchorSideLeft.Control = btnMemoryView
btnDelAddressList.AnchorSideLeft.Side = asrBottom
btnDelAddressList.AnchorSideBottom.Control = btnMemoryView
btnDelAddressList.AnchorSideBottom.Side = asrBottom
btnDelAddressList.BorderSpacing.Left = 10

local btnStopAddressLogger = createButton(mfrm)
btnStopAddressLogger.Parent = btnMemoryView.getParent()
btnStopAddressLogger.Anchors = '[akLeft, akBottom]'
btnStopAddressLogger.AnchorSideLeft.Control = btnDelAddressList
btnStopAddressLogger.AnchorSideLeft.Side = asrBottom
btnStopAddressLogger.AnchorSideBottom.Control = btnDelAddressList
btnStopAddressLogger.AnchorSideBottom.Side = asrBottom
btnStopAddressLogger.BorderSpacing.Left = 10
btnStopAddressLogger.AutoSize = true
btnStopAddressLogger.Visible = false
btnStopAddressLogger.Caption = 'Stop AddressLogger'

local btnStartAddressLogger = createButton(mfrm)
btnStartAddressLogger.Parent = btnMemoryView.getParent()
btnStartAddressLogger.Anchors = '[akLeft, akBottom]'
btnStartAddressLogger.AnchorSideLeft.Control = btnDelAddressList
btnStartAddressLogger.AnchorSideLeft.Side = asrBottom
btnStartAddressLogger.AnchorSideBottom.Control = btnDelAddressList
btnStartAddressLogger.AnchorSideBottom.Side = asrBottom
btnStartAddressLogger.BorderSpacing.Left = 10
btnStartAddressLogger.AutoSize = true
btnStartAddressLogger.Visible = false
btnStartAddressLogger.Caption = 'Start AddressLogger'

local btnPauseAddressLogger = createButton(mfrm)
btnPauseAddressLogger.Parent = btnMemoryView.getParent()
btnPauseAddressLogger.Anchors = '[akLeft, akBottom]'
btnPauseAddressLogger.AnchorSideLeft.Control = btnStopAddressLogger
btnPauseAddressLogger.AnchorSideLeft.Side = asrBottom
btnPauseAddressLogger.AnchorSideBottom.Control = btnStopAddressLogger
btnPauseAddressLogger.AnchorSideBottom.Side = asrBottom
btnPauseAddressLogger.BorderSpacing.Left = 10
btnPauseAddressLogger.AutoSize = true
btnPauseAddressLogger.Visible = false
btnPauseAddressLogger.Caption = 'Pause AddressLogger'

local btnResumeAddressLogger = createButton(mfrm)
btnResumeAddressLogger.Parent = btnMemoryView.getParent()
btnResumeAddressLogger.Anchors = '[akLeft, akBottom]'
btnResumeAddressLogger.AnchorSideLeft.Control = btnStopAddressLogger
btnResumeAddressLogger.AnchorSideLeft.Side = asrBottom
btnResumeAddressLogger.AnchorSideBottom.Control = btnStopAddressLogger
btnResumeAddressLogger.AnchorSideBottom.Side = asrBottom
btnResumeAddressLogger.BorderSpacing.Left = 10
btnResumeAddressLogger.AutoSize = true
btnResumeAddressLogger.Visible = false
btnResumeAddressLogger.Caption = 'Resume AddressLogger'

local btnChangeTable = createButton(mfrm)
btnChangeTable.Parent = btnMemoryView.getParent()
btnChangeTable.Anchors = '[akLeft, akBottom]'
btnChangeTable.AnchorSideLeft.Control = btnStartAddressLogger
btnChangeTable.AnchorSideLeft.Side = asrBottom
btnChangeTable.AnchorSideBottom.Control = btnStartAddressLogger
btnChangeTable.AnchorSideBottom.Side = asrBottom
btnChangeTable.BorderSpacing.Left = 10
btnChangeTable.AutoSize = true
btnChangeTable.Visible = false
btnChangeTable.Caption = 'Change Table'

local btnChangeInterval = createButton(mfrm)
btnChangeInterval.Parent = btnMemoryView.getParent()
btnChangeInterval.Anchors = '[akLeft, akBottom]'
btnChangeInterval.AnchorSideLeft.Control = btnChangeTable
btnChangeInterval.AnchorSideLeft.Side = asrBottom
btnChangeInterval.AnchorSideBottom.Control = btnChangeTable
btnChangeInterval.AnchorSideBottom.Side = asrBottom
btnChangeInterval.BorderSpacing.Left = 10
btnChangeInterval.AutoSize = true
btnChangeInterval.Visible = false
btnChangeInterval.Caption = 'Change Interval'

local changeIntervalForm = createFormFromFile(getCheatEngineDir() .. "autorun\\AddressLogger\\frm\\changeInterval.frm")
changeIntervalForm.Width =  getScreenWidth() * .1
changeIntervalForm.Height =   getScreenHeight() * .1
changeIntervalForm.Constraints.MinWidth = getScreenWidth() * .1
changeIntervalForm.Constraints.MinHeight = getScreenHeight() * .1
changeIntervalForm.Position = poScreenCenter
changeIntervalForm.BorderStyle = bsSizeable
changeIntervalForm.Caption = 'Choose A New Interval'
changeIntervalForm.OnClose = function() return caHide end

local edtNewInterval = createEdit(changeIntervalForm)
edtNewInterval.AnchorSideTop.Control = changeIntervalForm
edtNewInterval.AnchorSideLeft.Control = changeIntervalForm
edtNewInterval.MaxLength = 10
edtNewInterval.BorderSpacing.Top = 10
edtNewInterval.BorderSpacing.Right = 10
edtNewInterval.BorderSpacing.Bottom = 10
edtNewInterval.BorderSpacing.Left = 10
edtNewInterval.Alignment = 2 -- center
edtNewInterval.Align = alTop
edtNewInterval.Constraints.MinWidth = 50
edtNewInterval.NumbersOnly = true

local btnNewInterval = createButton(changeIntervalForm)
btnNewInterval.AnchorSideTop.Control = edtNewInterval
btnNewInterval.AnchorSideTop.Side = asrBottom
btnNewInterval.Align = alClient
btnNewInterval.AutoSize = true
btnNewInterval.Caption = 'Change Interval'

local Gbox = createGroupBox(tsExtra)
Gbox.AnchorSideTop.Control = cbProcessWatcher
Gbox.AnchorSideTop.Side = asrBottom
Gbox.AnchorSideLeft.Control = cbProcessWatcher
Gbox.Hint = 'You must stop the AddressLogger before you can change these options again.'
Gbox.ShowHint = false
Gbox.AutoSize = true
Gbox.Caption = 'AddressLogger Options'

local LogChangesToAddress = createCheckBox(Gbox)
LogChangesToAddress.AnchorSideLeft.Control = Gbox
LogChangesToAddress.BorderSpacing.Left = 10
LogChangesToAddress.Caption = 'Log Changes to Cheat Table Addresses'
LogChangesToAddress.Hint = 'Values are saved in the AddressLogs\\Logs directory.'
LogChangesToAddress.ShowHint = true
LogChangesToAddress.Checked = false

local ShowChangesToAddress = createCheckBox(Gbox)
ShowChangesToAddress.AnchorSideTop.Control = LogChangesToAddress
ShowChangesToAddress.AnchorSideTop.Side = asrBottom
ShowChangesToAddress.AnchorSideLeft.Control = LogChangesToAddress
ShowChangesToAddress.Caption = 'Show Changes On Screen (will impact performance)'
ShowChangesToAddress.Hint = 'Display a window that shows live changes.'
ShowChangesToAddress.BorderSpacing.Right = 20
ShowChangesToAddress.ShowHint = true
ShowChangesToAddress.Checked = false

local cbAdvancedOptions = createCheckBox(Gbox)
cbAdvancedOptions.AnchorSideLeft.Control = ShowChangesToAddress
cbAdvancedOptions.AnchorSideTop.Control = ShowChangesToAddress
cbAdvancedOptions.AnchorSideTop.Side = asrBottom
cbAdvancedOptions.Caption = 'Show Advanced Options'

local gbAdvancedOptions = createGroupBox(Gbox)
gbAdvancedOptions.AnchorSideLeft.Control = cbAdvancedOptions
gbAdvancedOptions.AnchorSideTop.Control = cbAdvancedOptions
gbAdvancedOptions.AnchorSideTop.Side = asrBottom
gbAdvancedOptions.Caption = 'Advanced Options'
gbAdvancedOptions.BorderSpacing.Right = 10
gbAdvancedOptions.Autosize = true
gbAdvancedOptions.Visible = false

local pnlAdvancedOptions = createPanel(gbAdvancedOptions)
pnlAdvancedOptions.Color = 0xF0F0F0
pnlAdvancedOptions.BorderSpacing.Right = 10
pnlAdvancedOptions.BorderSpacing.Left = 10
pnlAdvancedOptions.BorderSpacing.Bottom = 10
pnlAdvancedOptions.Autosize = true

local cbRequireFocusedWindow = createCheckBox(pnlAdvancedOptions)
cbRequireFocusedWindow.AnchorSideLeft.Control = pnlAdvancedOptions
cbRequireFocusedWindow.BorderSpacing.Left = 10
cbRequireFocusedWindow.Caption = 'Only log changes when process is focused'
cbRequireFocusedWindow.Checked = false

local cbAddressInfoFile = createCheckBox(pnlAdvancedOptions)
cbAddressInfoFile.AnchorSideLeft.Control = cbRequireFocusedWindow
cbAddressInfoFile.AnchorSideTop.Control = cbRequireFocusedWindow
cbAddressInfoFile.AnchorSideTop.Side = asrBottom
cbAddressInfoFile.Caption = "Do not create AddressInformation file"

local cbOneAddressChange = createCheckBox(pnlAdvancedOptions)
cbOneAddressChange.AnchorSideLeft.Control = cbAddressInfoFile
cbOneAddressChange.AnchorSideTop.Control = cbAddressInfoFile
cbOneAddressChange.AnchorSideTop.Side = asrBottom
cbOneAddressChange.Caption = 'Log on address breakpoint'
cbOneAddressChange.Hint = 'Check to log everytime a specific address changes.'
cbOneAddressChange.ShowHint = true

local edtOneAddressChange = createEdit(pnlAdvancedOptions)
edtOneAddressChange.AnchorSideLeft.Control = cbOneAddressChange
edtOneAddressChange.AnchorSideTop.Control = cbOneAddressChange
edtOneAddressChange.AnchorSideTop.Side = asrBottom
edtOneAddressChange.Constraints.MinWidth = getScreenWidth() * .08
edtOneAddressChange.BorderSpacing.Top = 5
edtOneAddressChange.BorderSpacing.Bottom = 5
edtOneAddressChange.Visible = false

local lblOneAddressChange = createLabel(pnlAdvancedOptions)
lblOneAddressChange.AnchorSideLeft.Control = edtOneAddressChange
lblOneAddressChange.AnchorSideLeft.Side = asrBottom
lblOneAddressChange.AnchorSideTop.Control = cbOneAddressChange
lblOneAddressChange.AnchorSideTop.Side = asrBottom
lblOneAddressChange.BorderSpacing.Left = 10
lblOneAddressChange.BorderSpacing.Top = 7
lblOneAddressChange.Caption = 'Enter the address to track'
lblOneAddressChange.Hint = 'Do not enter the base address.'
lblOneAddressChange.ShowHint = true
lblOneAddressChange.Visible = false

local cbStartupProcess = createCheckBox(pnlAdvancedOptions)
cbStartupProcess.AnchorSideLeft.Control = edtOneAddressChange
cbStartupProcess.AnchorSideTop.Control = edtOneAddressChange
cbStartupProcess.AnchorSideTop.Side = asrBottom
cbStartupProcess.Caption = 'Automatically attach a process on startup'

local edtStartupProcess = createEdit(pnlAdvancedOptions)
edtStartupProcess.AnchorSideLeft.Control = cbStartupProcess
edtStartupProcess.AnchorSideTop.Control = cbStartupProcess
edtStartupProcess.AnchorSideTop.Side = asrBottom
edtStartupProcess.Constraints.MinWidth = getScreenWidth() * .08
edtStartupProcess.BorderSpacing.Top = 5
edtStartupProcess.BorderSpacing.Bottom = 10
edtStartupProcess.Alignment = 2
edtStartupProcess.Visible = false

local lblStartupProcess = createLabel(pnlAdvancedOptions)
lblStartupProcess.AnchorSideLeft.Control = edtStartupProcess
lblStartupProcess.AnchorSideLeft.Side = asrBottom
lblStartupProcess.AnchorSideTop.Control = cbStartupProcess
lblStartupProcess.AnchorSideTop.Side = asrBottom
lblStartupProcess.Caption = 'Enter the process to attach'
lblStartupProcess.Hint = 'Do not surround the process name with quotes.'
lblStartupProcess.BorderSpacing.Top = 7
lblStartupProcess.BorderSpacing.Left = 10
lblStartupProcess.BorderSpacing.Right = 20
lblStartupProcess.ShowHint = true
lblStartupProcess.Visible = false

local edtInterval = createEdit(Gbox)
edtInterval.AnchorSideTop.Control = gbAdvancedOptions
edtInterval.AnchorSideTop.Side = asrBottom
edtInterval.AnchorSideLeft.Control = gbAdvancedOptions
edtInterval.MaxLength = 10
edtInterval.BorderSpacing.Top = 10
edtInterval.BorderSpacing.Bottom = 10
edtInterval.Text = 1000
edtInterval.Alignment = 2 -- center
edtInterval.Constraints.MinWidth = 50
edtInterval.Width = edtInterval.Text:len() * getScreenWidth() * .0078
edtInterval.OnChange = function () edtInterval.Width = edtInterval.Text:len() * getScreenWidth() * .0078 end
edtInterval.NumbersOnly = true
edtInterval.Enabled = false

local lblInterval = createLabel(Gbox)
lblInterval.AnchorSideLeft.Control = edtInterval
lblInterval.AnchorSideLeft.Side = asrBottom
lblInterval.AnchorSideTop.Control = gbAdvancedOptions
lblInterval.AnchorSideTop.Side = asrBottom
lblInterval.BorderSpacing.Top = 7
lblInterval.BorderSpacing.Left = 10
lblInterval.Caption = 'Logging Interval (ms)'

local showChangesForm = createFormFromFile(getCheatEngineDir() .. "autorun\\AddressLogger\\frm\\showChanges.frm")
showChangesForm.Width =  getScreenWidth() * .34
showChangesForm.Height =   getScreenHeight() * .42
showChangesForm.Constraints.MinWidth = getScreenWidth() * .1
showChangesForm.Constraints.MinHeight = getScreenHeight() * .1
showChangesForm.Position = poScreenCenter
showChangesForm.BorderStyle = bsSizeable
showChangesForm.OnClose = function() return caHide end

local pnlInfo = createPanel(showChangesForm)
pnlInfo.Anchors = '[akTop]'
pnlInfo.AnchorSideTop.Control = showChangesForm
pnlInfo.AnchorSideTop.Side = asrBottom
pnlInfo.Align = alTop
pnlInfo.BevelOuter = bvNone
pnlInfo.Constraints.MinHeight = getScreenHeight() * .0324
pnlInfo.AutoSize = true

local lblCurrentCT = createLabel(pnlInfo)
lblCurrentCT.Anchors = '[akLeft, akBottom]'
lblCurrentCT.AnchorSideLeft.Control = pnlInfo
lblCurrentCT.AnchorSideLeft.Side = asrTop
lblCurrentCT.AnchorSideBottom.Control = pnlInfo
lblCurrentCT.AnchorSideBottom.Side = asrBottom
lblCurrentCT.BorderSpacing.Bottom = pnlInfo.Height * 1/7
lblCurrentCT.BorderSpacing.Top = pnlInfo.Height * 1/7
lblCurrentCT.BorderSpacing.Left = pnlInfo.Height * 1/7
lblCurrentCT.Caption = 'CT: NA'
lblCurrentCT.Font.Style = 'fsBold'

local lblCurrentInt = createLabel(pnlInfo)
lblCurrentInt.Anchors = '[akLeft, akBottom]'
lblCurrentInt.AnchorSideLeft.Control = lblCurrentCT
lblCurrentInt.AnchorSideLeft.Side = asrBottom
lblCurrentInt.AnchorSideBottom.Control = pnlInfo
lblCurrentInt.AnchorSideBottom.Side = asrBottom
lblCurrentInt.BorderSpacing.Bottom = pnlInfo.Height * 1/7
lblCurrentInt.BorderSpacing.Top = pnlInfo.Height * 1/7
lblCurrentInt.BorderSpacing.Left = pnlInfo.Height * 2/7
lblCurrentInt.Caption = 'Interval: NA'

local btnLockScroll = createButton(pnlInfo)
btnLockScroll.Anchors = '[akRight, akBottom]'
btnLockScroll.AnchorSideRight.Control = pnlInfo
btnLockScroll.AnchorSideRight.Side = asrTop
btnLockScroll.AnchorSideBottom.Control = pnlInfo
btnLockScroll.AnchorSideBottom.Side = asrBottom
btnLockScroll.Align = alRight
btnLockScroll.BorderSpacing.Right = 10
btnLockScroll.AutoSize = true
btnLockScroll.Caption = 'Unlock Scrollbar'

local btnChangeAddressViewMode = createButton(pnlInfo)
btnChangeAddressViewMode.Anchors = '[akRight, akBottom]'
btnChangeAddressViewMode.AnchorSideRight.Control = btnLockScroll
btnChangeAddressViewMode.AnchorSideRight.Side = asrBottom
btnChangeAddressViewMode.AnchorSideBottom.Control = pnlInfo
btnChangeAddressViewMode.AnchorSideBottom.Side = asrBottom
btnChangeAddressViewMode.Align = alRight
btnChangeAddressViewMode.AutoSize = true
btnChangeAddressViewMode.Caption = 'Show Descriptions'

local lvShowChanges = createListView(showChangesForm)
lvShowChanges.Anchors = '[akTop]'
lvShowChanges.AnchorSideTop.Control = pnlInfo
lvShowChanges.AnchorSideTop.Side = asrBottom
lvShowChanges.Align = alBottom
lvShowChanges.ViewStyle = vsReport
lvShowChanges.GridLines = true


--[[
   END GUI ELEMENTS
   BEGIN MAIN IMPLEMENTATION
  ]]


local function readOptions()
-- reads the advanced options
  local processFile = assert(io.open(getCheatEngineDir() .. "autorun\\AddressLogger\\settings.txt", "r"))
  if processFile:read() == "true" then
    cbAdvancedOptions.Checked = true
    gbAdvancedOptions.Visible = true
  end
  if processFile:read() == "true" then
    cbRequireFocusedWindow.Checked = true
  end
  if processFile:read() == "true" then
    cbAddressInfoFile.Checked = true
  end
  if processFile:read() == "true" then
    cbOneAddressChange.Checked = true
    edtOneAddressChange.Visible = true
    lblOneAddressChange.Visible = true
  end
  edtOneAddressChange.Text = processFile:read()
  if processFile:read() == "true" then
    cbStartupProcess.Checked = true
    edtStartupProcess.Visible = true
    lblStartupProcess.Visible = true

    local processToAttach = processFile:read()
    edtStartupProcess.Text = processToAttach
    if openProcess(processToAttach) == nil then
      messageDialog("-- AddressLogger Warning --\nYour process could not be automatically attached. Please be sure it is opened and typed correctly.", mtWarning, mbOK)
    end
  end
  processFile:close()
end
readOptions()

local function decimalToHex(decNum)
-- returns the hexadecimal version of a decimal number
  return string.upper(string.format("%x", decNum * 16))
end

local function getLogTimeFormat(time)
-- gets the formatted string for a time (a number of milliseconds)
  local ttime = 0 -- the theoretical time, formatted HH:MM:SS:mmm
  local hours, minutes, seconds, milliseconds = 0, 0, 0, 0

  hours = string.format("%02.f", math.floor(time/3600000))
  minutes = string.format("%02.f", math.floor((time - (hours*3600000))/60000))
  seconds = string.format("%02.f", math.floor((time - (hours*3600000) - (minutes*60000))/1000))
  milliseconds = string.format("%03.f", math.floor((time - (hours*3600000) - (minutes*60000) - (seconds*1000))))
  ttime = hours..":"..minutes..":"..seconds..":"..milliseconds

  return ttime
end

local function createLogFile(realAddresses)
-- creates the AddressLogs CSV file
  local sep = ","
  local ttimes = {} -- array of theoretical times
  local numAddresses = 0
  local counter = 0
  local colNames = "Real Time"..sep.."Log Time"
  for num, address in ipairs(realAddresses) do
    colNames = colNames..sep..decimalToHex(address)
    numAddresses = num
  end

  -- calculate theoretical times
  for num, _ in ipairs(times) do
    table.insert(ttimes, getLogTimeFormat((num-1) * interval))
  end

  -- writing to the file
  createThread(function()
    local file = assert(io.open(logPath, "w"))
    file:write("sep="..sep.."\n"..colNames)

    for num, time in ipairs(times) do
      if cbOneAddressChange.getState() == 1 then
        file:write("\n"..time..sep.."NA")
      else
        file:write("\n"..time..sep..ttimes[num])
      end
      for i = 1, numAddresses do
        file:write(sep..addressValues[i+(counter*numAddresses)])
      end
      counter = counter + 1
    end
    file:close()
  end)
end

local function createInfoFile(CheatEntries, maxNumOffsets, multipleEntries)
-- creates the AddressInformation CSV file
  -- we also get the realAddresses and addressTypes from this function
  
  -- set column names
  local sep = ","
  local colNames = "ID"..sep.."Description"..sep.."Type"..sep.."Address"
  for i = 1, maxNumOffsets do
    colNames = colNames..sep.."Offset "..i
  end

  -- writing to the file
  local file = nil
  if cbAddressInfoFile.Checked == false then -- log to file if not checked
    file = assert(io.open(infoPath, "w"))
  end
  realAddresses = {} -- global table for calcuating address(es) + offset(s)
  addressTypes = {} -- for the address variable types in order
  local currentOffsets = {} -- also for realAddresses
  local counter = 0
  if cbAddressInfoFile.Checked == false then
    file:write("sep="..sep.."\n"..colNames)
  end

  if multipleEntries == false then
    local v = CheatEntries.CheatEntry
    if cbAddressInfoFile.Checked == false then
      file:write("\n"..v.ID..sep..v.Description:sub(2,-2)..sep..v.VariableType..sep..v.Address)
    end
    if v.VariableType == "Array of byte" then
      table.insert(addressTypes, v.VariableType .. " - " .. v.ByteLength)
    elseif v.VariableType == "Binary" then
      table.insert(addressTypes, v.VariableType .. " - " .. v.BitStart .. v.BitLength)
    else
      table.insert(addressTypes, v.VariableType)
    end

    if v.Address:find('"+') ~= nil then -- for base addresses with an offset
      table.insert(realAddresses, readPointer(getAddress(v.Address)))
    else -- for normal addresses
      table.insert(realAddresses, getAddress(v.Address))
    end

    if v.Offsets ~= nil then 
      for _, offset in ipairs(v.Offsets.Offset) do
        if cbAddressInfoFile.Checked == false then
          file:write(sep..offset)
        end
        table.insert(currentOffsets, offset)
        counter = counter + 1
      end
      for offsetNum = 0, counter-1 do -- side process: tracing our pointer to the real address
        if readPointer(realAddresses[1] + tonumber(currentOffsets[counter-offsetNum], 16)) == nil then
          messageDialog("Your Cheat Table contains an invalid pointer.\nThe address [" .. v.Address .. "] will not log correctly.", mtWarning, mbOK)
          break
        elseif counter-offsetNum == 1 then -- the elseif and else are reading the pointer offsets in reverse
          realAddresses[1] = getAddress(realAddresses[1] + tonumber(currentOffsets[counter-offsetNum], 16))
        else
          realAddresses[1] = readPointer(realAddresses[1] + tonumber(currentOffsets[counter-offsetNum], 16))
        end
      end
    end

  elseif multipleEntries == true then
    for i, v in ipairs(CheatEntries) do
      if cbAddressInfoFile.Checked == false then
        file:write("\n"..v.ID..sep..v.Description:sub(2,-2)..sep..v.VariableType..sep..v.Address)
      end
      if v.VariableType == "Array of byte" then
        table.insert(addressTypes, v.VariableType .. " - " .. v.ByteLength)
      elseif v.VariableType == "Binary" then
        table.insert(addressTypes, v.VariableType .. " - " .. v.BitStart .. v.BitLength)
      else
        table.insert(addressTypes, v.VariableType)
      end

      if v.Address:find('"+') ~= nil then -- for base addresses with an offset
        table.insert(realAddresses, readPointer(getAddress(v.Address)))
      else -- for normal addresses
        table.insert(realAddresses, getAddress(v.Address))
      end

      if v.Offsets ~= nil then 
        for _, offset in ipairs(v.Offsets.Offset) do
          if cbAddressInfoFile.Checked == false then
            file:write(sep..offset)
          end
          table.insert(currentOffsets, offset)
          counter = counter + 1
        end
        for offsetNum = 0, counter-1 do -- side process: tracing our pointers to the real addresses
          if readPointer(realAddresses[i] + tonumber(currentOffsets[counter-offsetNum], 16)) == nil then
            messageDialog("Your Cheat Table contains an invalid pointer.\nThe address [" .. v.Address .. "] will not log correctly.", mtWarning, mbOK)
            break
          elseif counter-offsetNum == 1 then -- the elseif and else are reading the pointer offsets in reverse
            realAddresses[i] = getAddress(realAddresses[i] + tonumber(currentOffsets[counter-offsetNum], 16))
          else
            realAddresses[i] = readPointer(realAddresses[i] + tonumber(currentOffsets[counter-offsetNum], 16))
          end
        end
        currentOffsets = {}
      end

      if counter < maxNumOffsets then -- ensuring equal row length
        if cbAddressInfoFile.Checked == false then
          for count = 1, maxNumOffsets-counter do file:write(sep) end
        end
      end

      counter = 0
    end
  end
  if cbAddressInfoFile.Checked == false then file:close() end
  return addressTypes
end

local function readAddressValue(address, addressType)
-- reads the current value at the given address
  local v = 0 -- current value
  if addressType == "Byte" then
    v = readBytes(address, 1)
  elseif addressType == "2 Bytes" then
    v = readSmallInteger(address)
  elseif addressType == "4 Bytes" then
    v = readInteger(address)
  elseif addressType == "8 Bytes" then
    v = readQword(address)
  elseif addressType == "Float" then
    v = readFloat(address)
  elseif addressType == "Double" then
    v = readDouble(address)
  elseif addressType == "String" then
    v = readString(address, 6000)
  elseif addressType:sub(1, 13) == "Array of byte" then -- byte length included in type
    v = table.concat(readBytes(address, addressType:sub(17), true), " ")
  elseif addressType:sub(1, 6) == "Binary" then -- bit start and length included
    v = readQword(address) >> addressType:sub(10, 10) & (1 << addressType:sub(11)) - 1
  else
    btnStopAddressLogger.doClick()
    messageDialog("Unknown type for address: " .. decimalToHex(address) .. "\nScript aborted.", mtError, mbOK)
  end
  if v == nil then v = "?????" end -- good type but unknown value
  return v
end

local function findWindowHandleOfProcess()
-- gets the window handle of the currently attached process
  local openedPID = getOpenedProcessID()
  local windowList = getWindowlist()
  local windowCaption = ""

  for PID, data in pairs(windowList) do
    for _, caption in pairs(data) do
      if PID == openedPID then
        windowCaption = caption
      end
    end
  end

  local processWindow = findWindow(null, windowCaption)
  if processWindow == nil or processWindow == 0 then
    messageDialog("Could not locate window handle of currently attached process. Logging will continue to take place without the process window in focus.", mtWarning, mbOK)
  end
  return processWindow
end

local function startLogging()
-- logs cheat table changes to a table
  -- importing slimer
  package.cpath = getCheatEngineDir() .. "autorun\\Addresslogger\\dlls\\?.dll;" .. package.cpath
  if cheatEngineIs64Bit() then
    slimer = require("slimerx64")
  else
    slimer = require("slimerx86")
  end

  addressValues = {} -- global table of current values in order
  times = {} -- global table of current real times (milliseconds not included)
  interval = tonumber(edtInterval.Text) or 1000 -- global timer interval
  log = true -- global log indicator

  local isRequireFocusChecked = cbRequireFocusedWindow.getState()
  local isOneAddressChangeChecked = cbOneAddressChange.getState()
  local processWindow = nil
  local startCount = nil -- start count of performance counter
  local endCount = nil -- end count of performance counter
  local per = slimer.period() -- period of performance coutner
  local breakpoint = edtOneAddressChange.Text -- address to log on breakpoint
  local breakpointIndex = nil -- index for breakpoint in realAddresses and addressTypes
  local previousValue = nil -- previous value of breakpoint address
  local time = 0 -- time count
  local icr = -1 -- incrementer

  if isRequireFocusChecked == 1 then
    processWindow = findWindowHandleOfProcess()
    if processWindow == nil or processWindow == 0 then isRequireFocusChecked = 0 end
  end

  if isOneAddressChangeChecked == 1 then
    interval = 1
    breakpoint = tonumber("0x"..breakpoint)
    for num, address in ipairs(realAddresses) do
      if breakpoint == address then
        breakpointIndex = num
      end
    end
  end

	-- main loop
  mainThread = createThread(function()
	  while log == true do
	  	-- timing loop to adjust for sleep time
	  	startCount = slimer.clock()

	    if isRequireFocusChecked == 1 then
	      if processWindow == getForegroundWindow() then -- only log when focused

	        if showChanges == true and isOneAddressChangeChecked == 0 then
	          icr = icr + 1
	          lvShowChanges.Items.add().Caption = os.date("%X")
	          lvShowChanges.Items.getItem(icr).SubItems.add(getLogTimeFormat(time))
	          if lockScroll == true then
	            lvShowChanges.Items.getItem(icr).makeVisible()
	          end
	          time = time + interval
	        end
            
          if isOneAddressChangeChecked == 1 then
            local currentValue = readAddressValue(breakpoint, addressTypes[breakpointIndex])
            if currentValue ~= previousValue then
              if showChanges == true then
                icr = icr + 1
                lvShowChanges.Items.add().Caption = os.date("%X")
                lvShowChanges.Items.getItem(icr).SubItems.add("NA")
                if lockScroll == true then
                  lvShowChanges.Items.getItem(icr).makeVisible()
                end
                time = time + interval
              end
              for num, address in ipairs(realAddresses) do
                local currentValue2 = readAddressValue(address, addressTypes[num])
                table.insert(addressValues, currentValue2) -- grows on every interval
                if showChanges == true then
                  lvShowChanges.Items.getItem(icr).SubItems.add(currentValue2)
                end
              end
              previousValue = currentValue
              table.insert(times, os.date("%X"))
            end
          else
  	        for num, address in ipairs(realAddresses) do
  	          local currentValue = readAddressValue(address, addressTypes[num])
  	          table.insert(addressValues, currentValue) -- grows on every interval
  	          if showChanges == true then
  	            lvShowChanges.Items.getItem(icr).SubItems.add(currentValue)
  	          end
  	        end
          end
	        table.insert(times, os.date("%X"))
	      end

	    else -- log continually unless paused
	      if showChanges == true and isOneAddressChangeChecked == 0 then
	        icr = icr + 1
	        lvShowChanges.Items.add().Caption = os.date("%X")
	        lvShowChanges.Items.getItem(icr).SubItems.add(getLogTimeFormat(time))
	        if lockScroll == true then
	          lvShowChanges.Items.getItem(icr).makeVisible()
	        end
	        time = time + interval
	      end

        if isOneAddressChangeChecked == 1 then
          local currentValue = readAddressValue(breakpoint, addressTypes[breakpointIndex])
          if currentValue ~= previousValue then
            if showChanges == true then
              icr = icr + 1
              lvShowChanges.Items.add().Caption = os.date("%X")
              lvShowChanges.Items.getItem(icr).SubItems.add("NA")
              if lockScroll == true then
                lvShowChanges.Items.getItem(icr).makeVisible()
              end
              time = time + interval
            end
            for num, address in ipairs(realAddresses) do
              local currentValue2 = readAddressValue(address, addressTypes[num])
              table.insert(addressValues, currentValue2) -- grows on every interval
              if showChanges == true then
                lvShowChanges.Items.getItem(icr).SubItems.add(currentValue2)
              end
            end
            previousValue = currentValue
            table.insert(times, os.date("%X"))
          end
        else
  	      for num, address in ipairs(realAddresses) do
  	        local currentValue = readAddressValue(address, addressTypes[num])
  	        table.insert(addressValues, currentValue) -- grows on every interval
  	        if showChanges == true then
  	          lvShowChanges.Items.getItem(icr).SubItems.add(currentValue)
  	        end
  	      end
  	      table.insert(times, os.date("%X"))
        end
	    end

	    endCount = slimer.clock()

      -- readers: 400 is a complete estimate on the time to call usleep function
      -- adjust for your machine if you need a really precise timer
	  	slimer.usleep(interval * 1000 - math.floor((endCount - startCount) * per * 1000000) - 400)
	  end
  end)
end

local function getCheatTableInformation(filename)
-- parses CT file into Lua Table
  -- importing XML parser to read CE table
  package.path = getCheatEngineDir() .. "autorun\\AddressLogger\\xml2lua-master\\?.lua;" .. package.path
  local xml2lua = require("xml2lua")
  local handler = require("xmlhandler.tree")
  local handler = handler:new()
  local xml = xml2lua.loadFile(filename)
  local parser = xml2lua.parser(handler)

  -- getting data
  parser:parse(xml)
  local CheatEntries = handler.root.CheatTable.CheatEntries

  -- iterating for multiple entries (xml2lua quirk)
  local multipleEntries = false
  if #CheatEntries.CheatEntry > 1 then
    CheatEntries = CheatEntries.CheatEntry
    multipleEntries = true
  end

  -- getting number of offsets
  local maxNumOffsets = 0
  if multipleEntries == false and CheatEntries.CheatEntry.Offsets ~= nil then
    for num, _ in ipairs(CheatEntries.CheatEntry.Offsets.Offset) do
      maxNumOffsets = num
    end
  elseif multipleEntries == true then
    for _, v in ipairs(CheatEntries) do
      if v.Offsets ~= nil then
        for num, _ in ipairs(v.Offsets.Offset) do
          maxNumOffsets = num
        end
      end
    end
  end

  -- date and time gets appended to file names
  local dateTime = os.date("%m%d%Y-%H%M%S")

  -- save paths; yes they are global
  infoPath = getCheatEngineDir() .. "autorun\\AddressLogger\\Logs\\AddressInformation-" .. dateTime .. ".CSV"
  logPath  = getCheatEngineDir() .. "autorun\\AddressLogger\\Logs\\AddressLogs-" .. dateTime .. ".CSV"

  -- we can make the info file now; the log file must come a little later
  createInfoFile(CheatEntries, maxNumOffsets, multipleEntries)

  -- handling properties of the showChanges form
  if showChanges == true then
    lblCurrentCT.Caption = filename:sub(filename:match('^.*()\\')+1)
    lblCurrentInt.Caption = "Interval: " .. edtInterval.Text .. "ms"
    btnChangeAddressViewMode.Caption = "Show Descriptions"
    local showDescriptions = true
    local addrWidths = {}
    local descWidths = {}
    lockScroll = true -- global

    lvShowChanges.Items.clear()
    lvShowChanges.Columns.clear()
    showChangesForm.show()

    -- time column initializations
    lvShowChanges.Columns.add().Caption = "00:00:00"
    lvShowChanges.Columns.add().Caption = "00:00:00:000"
    lvShowChanges.Columns.getColumn(0).AutoSize = true
    lvShowChanges.Columns.getColumn(1).AutoSize = true
    lvShowChanges.Columns.getColumn(0).Width = lvShowChanges.Columns.getColumn(0).Width
    lvShowChanges.Columns.getColumn(1).Width = lvShowChanges.Columns.getColumn(1).Width
    lvShowChanges.Columns.getColumn(0).AutoSize = false
    lvShowChanges.Columns.getColumn(1).AutoSize = false
    lvShowChanges.Columns.getColumn(0).Caption = "RTime"
    lvShowChanges.Columns.getColumn(1).Caption = "LTime"

    if multipleEntries == false then
      lvShowChanges.Columns.add().Caption = CheatEntries.CheatEntry.Description:sub(2,-2)
      lvShowChanges.Columns.getColumn(2).AutoSize = true
      table.insert(descWidths, lvShowChanges.Columns.getColumn(2).Width)
      lvShowChanges.Columns.getColumn(2).Caption = decimalToHex(realAddresses[1])
      table.insert(addrWidths, lvShowChanges.Columns.getColumn(2).Width)
      lvShowChanges.Columns.getColumn(2).AutoSize = false
      btnChangeAddressViewMode.Caption = "Show Description"
    else
      -- getting descWidths
      for num, value in ipairs(CheatEntries) do
        lvShowChanges.Columns.add().Caption = value.Description:sub(2,-2)
        lvShowChanges.Columns.getColumn(num+1).AutoSize = true
        table.insert(descWidths, lvShowChanges.Columns.getColumn(num+1).Width)
      end
      -- getting addrWidths
      for num, address in ipairs(realAddresses) do
        lvShowChanges.Columns.getColumn(num+1).Caption = decimalToHex(address)
        table.insert(addrWidths, lvShowChanges.Columns.getColumn(num+1).Width)
        lvShowChanges.Columns.getColumn(num+1).AutoSize = false
      end
    end

    function btnChangeAddressViewMode.OnClick()
      if showDescriptions == true then
        if multipleEntries == false then
          lvShowChanges.Columns.getColumn(2).Caption = CheatEntries.CheatEntry.Description:sub(2,-2)
          lvShowChanges.Columns.getColumn(2).Width = descWidths[1]
          btnChangeAddressViewMode.Caption = "Show Address"
        else
          for num, value in ipairs(CheatEntries) do
            lvShowChanges.Columns.getColumn(num+1).Caption = value.Description:sub(2,-2)
            lvShowChanges.Columns.getColumn(num+1).Width = descWidths[num]
          end
          btnChangeAddressViewMode.Caption = "Show Addresses"
        end
        showDescriptions = false
      elseif showDescriptions == false then 
        if multipleEntries == false then
          lvShowChanges.Columns.getColumn(2).Caption = decimalToHex(realAddresses[1])
          lvShowChanges.Columns.getColumn(2).Width = addrWidths[1]         
          btnChangeAddressViewMode.Caption = "Show Description"
        else
          for num, address in ipairs(realAddresses) do
            lvShowChanges.Columns.getColumn(num+1).Caption = decimalToHex(address)
            lvShowChanges.Columns.getColumn(num+1).Width = addrWidths[num]
          end
          btnChangeAddressViewMode.Caption = "Show Descriptions"
        end
        showDescriptions = true
      end
    end

    function btnLockScroll.OnClick()
      if lockScroll == true then
        lockScroll = false
        btnLockScroll.Caption = "Lock Scrollbar"
      elseif lockScroll == false then
        lockScroll = true
        btnLockScroll.Caption = "Unlock Scrollbar"
      end
    end
  end

  startLogging()

end

local function loadCheatTable(start)
-- function loads cheat table on ok 
  -- checking interval
  if tonumber(edtInterval.Text) == 0 then messageDialog("Invalid interval.", mtError, mbOK) return end

  -- checking for opened process
  if process == nil then -- process is a CE global variable
    messageDialog("There is no opened process. Attach a process to log values.", mtError, mbOK)
    return
  end

  -- get env variables
  local os = require("os")
  if os.getenv("USERNAME") ~= nil then
    username = os.getenv("USERNAME")
  end
  if os.getenv("Path") ~= nil then
    drive = os.getenv("Path")
    drive = drive:sub(1,3)
  end

  -- dialog creation and options
  if loadDialog.InitialDir == "0" then
    loadDialog.InitialDir = drive .. "Users\\" .. username .. "\\Documents\\My Cheat Tables"
  end -- we only want this to be the InitialDir the first time
  loadDialog.Options = "[ofNoChangeDir, ofEnableSizing, ofViewDetail]"
  loadDialog.DefaultExt = "CT"
  loadDialog.Title = 'Choose a Cheat Table to Log'
  if loadDialog.Execute() then
    -- getting the file
    filename = loadDialog.FileName -- global
    loadDialog.InitialDir = filename
  else
    filename = ""
  end

  -- for canceling
  if filename == "" and start == false then
    messageDialog("Canceling unloads the current Cheat Table. Visit the Settings if you want to log again.", mtWarning, mbOK)
    btnStartAddressLogger.Visible = false
    btnChangeTable.Visible = false
    btnChangeInterval.Visible = false
    return
  end

  if filename == "" and start ~= false then
    btnStartAddressLogger.Visible = false
    btnChangeTable.Visible = false
    btnChangeInterval.Visible = false
    return
  end

  -- checking file extension
  if filename ~= "" and filename:sub(-3) ~= loadDialog.DefaultExt then
    messageDialog("You must select a Cheat Table file with the .CT extension. Script aborted.", mtError, mbOK)
    loadDialog.InitialDir = "0"
    loadDialog.FileName = ""
    return
  end

  -- continuing if everything is good so far
  if filename ~= "" and start ~= false then
    btnStopAddressLogger.Visible = true
    btnPauseAddressLogger.Visible = true
    btnStartAddressLogger.Visible = false
    btnChangeTable.Visible = false
    btnChangeInterval.Visible = false
    LogChangesToAddress.Enabled = false
    LogChangesToAddress.ShowHint = false
    ShowChangesToAddress.Enabled = false
    ShowChangesToAddress.ShowHint = false
    cbRequireFocusedWindow.Enabled = false
    edtInterval.Enabled = false
    cbAdvancedOptions.Enabled = false
    gbAdvancedOptions.Enabled = false
    cbAddressInfoFile.Enabled = false
    cbOneAddressChange.Enabled = false
    cbOneAddressChange.ShowHint = false
    edtOneAddressChange.Enabled = false
    lblOneAddressChange.ShowHint = false
    cbStartupProcess.Enabled = false
    edtStartupProcess.Enabled = false
    lblStartupProcess.ShowHint = false
    Gbox.Enabled = false
    Gbox.ShowHint = true
    btnOK.OnClick = btnOKOnClick
    getCheatTableInformation(filename)
  end
end

local function btnOKResponse(...)
-- initial gui and implementation function
  showChanges = false -- global

  -- checking state
  local isLogChecked = LogChangesToAddress.getState()
  local isShowChecked = ShowChangesToAddress.getState()
  
  -- the timer allows the Settings form to finish closing before executing
  local timer = createTimer(nil, true)
  timer.Interval = 1

  -- updating advanced options
  local processFile = assert(io.open(getCheatEngineDir() .. "autorun\\AddressLogger\\settings.txt", "w"))
  if cbAdvancedOptions.Checked == true then processFile:write("true\n")
  else processFile:write("false\n") end
  if cbRequireFocusedWindow.Checked == true then processFile:write("true\n")
  else processFile:write("false\n") end
  if cbAddressInfoFile.Checked      == true then processFile:write("true\n")
  else processFile:write("false\n") end
  if cbOneAddressChange.Checked     == true then processFile:write("true\n"..edtOneAddressChange.Text.."\n")
  else processFile:write("false\n\n") end
  if cbStartupProcess.Checked == true then
    processFile:write("true\n")
    processFile:write(edtStartupProcess.Text)
  else
    processFile:write("false")
  end
  processFile:close()

  if isShowChecked == 1 then
    btnOKOnClick(...)
    timer.OnTimer = function()
      timer.destroy()
      showChanges = true
      loadCheatTable()
    end return
  elseif isLogChecked == 1 then
    btnOKOnClick(...)
    timer.OnTimer = function()
      timer.destroy()
      loadCheatTable()
    end return
  else
    btnStopAddressLogger.Visible = false
    btnPauseAddressLogger.Visible = false
    btnStartAddressLogger.Visible = false
    btnResumeAddressLogger.Visible = false
    btnChangeTable.Visible = false
    btnChangeInterval.Visible = false
  end return btnOKOnClick(...)
end
btnOK.OnClick = btnOKResponse


--[[
    END MAIN IMPLEMENTATION
    BEGIN GUI EVENT HANDLERS
  ]]


function btnStopAddressLogger.OnClick()
  log = false
  mainThread.terminate()
  btnStopAddressLogger.Visible = false
  btnPauseAddressLogger.Visible = false
  btnResumeAddressLogger.Visible = false
  btnStartAddressLogger.Visible = true
  btnChangeTable.Visible = true
  btnChangeInterval.Visible = true
  LogChangesToAddress.Enabled = true
  LogChangesToAddress.ShowHint = true
  ShowChangesToAddress.Enabled = true
  ShowChangesToAddress.ShowHint = true
  cbRequireFocusedWindow.Enabled = true
  edtInterval.Enabled = true
  cbAdvancedOptions.Enabled = true
  gbAdvancedOptions.Enabled = true
  cbAddressInfoFile.Enabled = true
  cbOneAddressChange.Enabled = true
  cbOneAddressChange.ShowHint = true
  edtOneAddressChange.Enabled = true
  lblOneAddressChange.ShowHint = true
  cbStartupProcess.Enabled = true
  edtStartupProcess.Enabled = true
  lblStartupProcess.ShowHint = true
  Gbox.Enabled = true
  Gbox.ShowHint = false
  showChangesForm.close()
  btnOK.OnClick = btnOKResponse
  createLogFile(realAddresses)
end

function btnPauseAddressLogger.OnClick()
  btnPauseAddressLogger.Visible = false
  btnResumeAddressLogger.Visible = true
  pause()
  mainThread.suspend()
end

function btnResumeAddressLogger.OnClick()
  btnPauseAddressLogger.Visible = true
  btnResumeAddressLogger.Visible = false
  unpause()
  mainThread.resume()
end

function btnStartAddressLogger.OnClick()
  btnStopAddressLogger.Visible = true
  btnPauseAddressLogger.Visible = true
  btnStartAddressLogger.Visible = false
  btnChangeTable.Visible = false
  btnChangeInterval.Visible = false
  LogChangesToAddress.Enabled = false
  LogChangesToAddress.ShowHint = false
  ShowChangesToAddress.Enabled = false
  ShowChangesToAddress.ShowHint = false
  cbRequireFocusedWindow.Enabled = false
  edtInterval.Enabled = false
  cbAdvancedOptions.Enabled = false
  gbAdvancedOptions.Enabled = false
  cbAddressInfoFile.Enabled = false
  cbOneAddressChange.Enabled = false
  cbOneAddressChange.ShowHint = false
  edtOneAddressChange.Enabled = false
  lblOneAddressChange.ShowHint = false
  cbStartupProcess.Enabled = false
  edtStartupProcess.Enabled = false
  lblStartupProcess.ShowHint = false
  Gbox.Enabled = false
  Gbox.ShowHint = true
  btnOK.OnClick = btnOKOnClick
  getCheatTableInformation(filename)
end

function btnChangeTable.OnClick()
  loadCheatTable(false)
end

function btnChangeInterval.OnClick()
  edtNewInterval.Text = tonumber(edtInterval.Text) or 1000
  btnNewInterval.OnClick = function() changeIntervalForm.close() edtInterval.Text = edtNewInterval.Text end
  changeIntervalForm.show()
end

function cbStartupProcess.OnChange()
  if cbStartupProcess.Checked == true then
    edtStartupProcess.Visible = true
    lblStartupProcess.Visible = true
  else
    edtStartupProcess.Visible = false
    lblStartupProcess.Visible = false
  end
end

function cbOneAddressChange.OnChange()
  if cbOneAddressChange.Checked == true then
    edtOneAddressChange.Visible = true
    lblOneAddressChange.Visible = true
  else
    edtOneAddressChange.Visible = false
    lblOneAddressChange.Visible = false
  end
end   

function cbAdvancedOptions.OnChange()
  if cbAdvancedOptions.Checked == true then
    gbAdvancedOptions.Visible = true
  else
    gbAdvancedOptions.Visible = false
  end
end

function ShowChangesToAddress.OnChange()
  if ShowChangesToAddress.Checked == true or LogChangesToAddress.Checked == true then
    edtInterval.Enabled = true
  else
    edtInterval.Enabled = false
  end
end

function LogChangesToAddress.OnChange()
  if LogChangesToAddress.Checked == true or ShowChangesToAddress.Checked == true then
    edtInterval.Enabled = true
  else
    edtInterval.Enabled = false
  end
end