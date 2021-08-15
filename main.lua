--- Entry point for the game pack management system.
alias_table = alias.add_group() -- Our alias table for registration
experiences = {}
Record = require "record"
function greet()
  blight.output("Welcome to the BlightMUD experience management system, brought to you by Hunter Jozwiak and contributors.")
  blight.output("Please enter the name of a game to launch it, or /explist to list the experiences you have available.")
end

function read_experience_files()
  local handle
  local experiences = {}
  handle = io.open("EXPERIENCES", "r")
  for line in handle:lines() do
    local dets = {}
    for token in line:gmatch("%S+") do
      print(token)
      table.insert(dets, token)
      end
      if rawlen(dets) < 4 then
        blight.output("Malformed record, skipping this.")
        for k, v in ipairs(dets) do print(k) print(v) end
        else
local rec = Record.create(table.unpack(dets))
table.insert(experiences, rec)
end
    end
return experiences
end


function main()
  greet()
  experiences = read_experience_files()
end
main()
