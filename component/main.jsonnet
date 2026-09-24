// main template for helm-chart
local kap = import 'lib/kapitan.libjsonnet';
local kube = import 'lib/kube.libjsonnet';
local inv = kap.inventory();
// The hiera parameters for the component
local params = inv.parameters.helm_chart;

// Define outputs below
{
  [if params.createNamespace then '00_namespace']: kube.Namespace(params.namespace),
}
