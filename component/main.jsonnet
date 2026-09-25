// main template for helm-chart
local kap = import 'lib/kapitan.libjsonnet';
local kube = import 'lib/kube.libjsonnet';
local inv = kap.inventory();
// The hiera parameters for the component
local params = inv.parameters.helm_chart;

local instance = inv.parameters._instance;
// Define outputs below
{
  [if params.createNamespace then '00_namespace']: kube.Namespace(params.namespace) + {
    metadata+: {
      labels+:
        {
          component: 'helm-chart',
          instance: instance,
        }
        + params.namespaceLabels,
      annotations+:
        {
          'syn.tools/source': 'https://github.com/bacluc-agent/component-helm-chart',
        }
        + params.namespaceAnnotations,
    },
  },
}
