// Recursively merge Helm values, unioning lists.
local unionArrays(defaults, overrides) =
  local go(acc, remaining) =
    if std.length(remaining) == 0 then
      acc
    else
      local x = remaining[0];
      local rest = remaining[1:];
      if std.member(acc, x) then
        go(acc, rest)
      else
        go(acc + [ x ], rest);
  go(defaults, overrides);

local mergeValues(defaults, overrides) =
  if std.isObject(defaults) && std.isObject(overrides) then
    {
      [k]:
        if std.objectHas(overrides, k) then
          mergeValues(defaults[k], overrides[k])
        else
          defaults[k]
      for k in std.objectFields(defaults)
    }
    + {
      [k]: overrides[k]
      for k in std.objectFields(overrides)
      if !std.objectHas(defaults, k)
    }
  else if std.isArray(defaults) && std.isArray(overrides) then
    unionArrays(defaults, overrides)
  else
    overrides;

{
  mergeValues:: mergeValues,
}
