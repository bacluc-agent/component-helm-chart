// Recursively merge Helm values, concatenating lists.
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
    defaults + overrides
  else
    overrides;

{
  mergeValues:: mergeValues,
}
