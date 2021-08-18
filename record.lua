local utils = require "utils"
-- A record structure for management of packs.
-- A record consists of the following fields:
-- * a name by which to launch the experience.
-- * the stem of the url to get the pack
-- * the username of the person
-- * the repository of the package itself.

local Record = {}
Record.__index = Record
-- The instantiation function for the record struct.
function Record.create(launch_command, repo_base, username, repo_name)
  local this = setmetatable({}, Record)
  this.launch_command = launch_command
  this.repo_base = repo_base
  this.username = username
  this.repo_name = repo_name
  return this
end
-- Find a record by its launch command.
-- table is a table of things to search through
-- cmd is the launch command
-- returns the first record that matches cmd, nil if no such record was ever found.
function Record.find_by_launch_command(table, cmd)
  for _,candidate in ipairs(table) do
    if candidate.launch_command == cmd then
      return candidate
    end
  end
  return nil
end

function Record:is_present()
  local plugins = plugin.get_all()
  for _,plugin in ipairs(plugins) do
    if self.repo_name == plugin then
      return true
    end
  end
  return false
end

function Record:create_alias(group)
  local format = string.format
  local regexp = regex.new(format("^%s$", self.launch_command))
  -- Now to create the actual alias
  group:add(regex, utils.handle_download)
end

function Record:print()
  blight.output("The plugin", self.repo_name, ", found at https://", self.repo_base, "/", self.username, "/", self.repo_name, " can be launched with the alias ", self.launch_command, ".")
  if self:is_present() then
    blight.output("The plugin is available for use.")
  else
    blight.output("The plugin needs to be fetched.")
  end
end
return Record
