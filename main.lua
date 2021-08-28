--- Entry point for the game pack management system.
alias_table = alias.add_group() -- Our alias table for registration
experiences = {}
Experience = require "experience"

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
      table.insert(dets, token)
      end
      if rawlen(dets) < 4 then
        blight.output("Malformed record, skipping this.")
        else
local exp = Experience.create(table.unpack(dets))
table.insert(experiences, exp)
end
    end
return experiences
end


function main()
  greet()
  experiences = read_experience_files()
  for _,exp in ipairs(experiences) do
exp:create_alias(alias_table)
  end
end
main()
