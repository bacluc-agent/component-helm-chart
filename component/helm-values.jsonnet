local kap = import 'lib/kapitan.libjsonnet';
local merge = import 'merge.libsonnet';
local inv = kap.inventory();
local params = inv.parameters.helm_chart;

local chart = params.charts.chart1;
local chartDir = '%s/helmcharts/%s-%s' % [
  inv.parameters._base_directory,
  chart.name,
  chart.version,
];
local valuesPath = chartDir + '/values.yaml';

assert std.length(std.objectFields(params.helm_values)) == 0 || kap.file_exists(valuesPath).exists :
       'Chart values file %s not found (chart %s@%s, instance %s). ' %
       [ valuesPath, chart.name, chart.version, inv.parameters._instance ] +
       'helm_values are non-empty and would be lost without the chart defaults. ' +
       'Check the kapitan helm dependency configuration in class/helm-chart.yml: ' +
       'version %s of %s must be fetched to output_path %s. ' %
       [ chart.version, chart.source, chartDir ];

local defaults =
  if kap.file_exists(valuesPath).exists then
    std.parseJson(kap.yaml_load(valuesPath))
  else
    {};

{
  ['merged-values-%s' % inv.parameters._instance]: merge.mergeValues(defaults, params.helm_values),
}
