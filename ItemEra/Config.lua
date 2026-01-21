local addonName, ItemEra = ...

local version = GetBuildInfo()
local major, minor, patch = version:match("^(%d+)%.(%d+)%.(%d+)")

ItemEra.CONFIG = {
    DEBUG = true,
    DISABLED_DB = false,
    VERSION = version,
    VERSION_MAJOR = tonumber(major),
    VERSION_MINOR = tonumber(minor),
    VERSION_PATCH = tonumber(patch)
}
