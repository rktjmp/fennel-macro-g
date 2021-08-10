-- How to avoid the following warning?
--
-- WARNING: Attempting to use global os in compile scope.
-- In future versions of Fennel this will not be allowed without the
-- --no-compiler-sandbox flag or passing a :compilerEnv globals table
-- in the options.
--

local fennel = require("fennel")

-- macro searcher
local macro_searcher = function(modname)
  if modname == "macro" then
    local fd = io.open("macro.fnl")
    local code = fd:read("*a")

    -- allowedGlobals: a sequential table of strings of the names of globals
    -- which the compiler will allow references to. Set to false to disable
    -- checks.
    local opts = {
      env = "_COMPILER",
      allowedGlobals = false -- still errors
    }

    opts = {
      env = "_COMPILER",
      allowedGlobals = {"_G"} -- lets _G.os work but now tostring is undefined, obviously
      -- seems very tedious to manually inject all the strings that exist by default
      -- could there be a merge option?
    }

    opts = {
      env = "_COMPILER",
      allowedGlobals = {"_G", "tostring"} -- still warns
      -- (and should really be .. "math" "table" ....... etc etc etc etc)
    }

    -- compilerEnv: an environment table in which to run compiler-scoped code
    -- for macro definitions and eval-compiler calls. Internal Fennel
    -- functions such as list, sym, etc. will be exposed in addition to this
    -- table. Defaults to a table containing limited known-safe globals. Pass
    -- _G to disable sandboxing.
    opts = {
      env = "_COMPILER",
      compilerEnv = _G -- same warning as original
      -- I guess setting a compilerEnv does not imply those are safe globals
    }

--    opts = {
--      env = "_COMPILER",
--      -- no effect, does allow for `os.date` in macro.fnl without "hard error"
--      compilerEnv = {os = os},
--      allowedGlobals = false -- same warnings
--    }


    return function()
      print("using custom macro searcher loader")
      return fennel.eval(code, opts), "macro.fnl"
    end
  end
end

table.insert(fennel["macro-searchers"], 1, macro_searcher)

fennel.dofile("module.fnl")
