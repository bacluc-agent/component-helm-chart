local kap = import 'lib/kapitan.libjsonnet';
local merge = import 'merge.libsonnet';
local inv = kap.inventory();
local params = inv.parameters.helm_chart;

local chart = params.charts.chart1;
local valuesPath = '%s/helmcharts/%s-%s/values.yaml' % [
  inv.parameters._base_directory,
  chart.name,
  chart.version,
];

local defaults =
  if kap.file_exists(valuesPath).exists then
    std.parseJson(kap.yaml_load(valuesPath))
  else
    {};

{
  ['merged-values-%s' % inv.parameters._instance]: merge.mergeValues(defaults, params.helm_values),
}
