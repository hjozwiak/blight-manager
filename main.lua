--- Entry point for the game pack management system.
local mod = {}
mod.alias_table = alias.add_group() -- Our alias table for registration
mod.experiences = {}
mod.Record = require "record"
function mod.greet()
  blight.output("Welcome to the BlightMUD experience management system, brought to you by Hunter Jozwiak and contributors.")
  blight.output("Please enter the name of a game to launch it, or /explist to list the experiences you have available.")
end

function mod.read_experience_files()
  local experiences = {}
  local handle = io.open("EXPERIENCES", "r")
  for line in handle:read() do
    local dets = {}
    for token in string.gmatch(line, "[!%s]+") do
      table.insert(dets, token)
      if rawlen(dets) < 4 then
        blight.output("Malformed record, skipping this.")
        else
local rec = mod.Record.create(table.unpack(dets))
table.insert(experiences, rec)
end
    end
end
return experiences
end


function mod.main()
  mod.greet()
  mod.experiences = mod.read_experience_files()
end
return mod
