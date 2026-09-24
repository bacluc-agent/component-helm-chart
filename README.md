# Commodore Component: helm-chart

This is a [Commodore][commodore] Component for helm-chart.

This can be used to deploy a helm chart to the cluster.
The component is multi-tenant, multi-instance and multi-version aware: each
instance gets its own namespace and can pin its own chart version.

By default the component installs the OCI chart `test-helm-chart` from
`oci://ghcr.io/bacluc-agent/test-helm-chart/test-helm-chart`.

## Documentation

Documentation for this component is written using [Asciidoc][asciidoc] and [Antora][antora].
It can be found in the [`docs`](docs) folder.
We use the [Divio documentation structure](https://documentation.divio.com/) to organize our documentation.

Run the `make docs-serve` command in the root of the project, and then browse to http://localhost:2020 to see a preview of the current state of the documentation.

After writing the documentation, please use the `make docs-vale` command and correct any warnings raised by the tool.

## Testing

The component is tested with two instances, `defaults` and `with_values`:

- `make test -e instance=defaults`
- `make test -e instance=with_values`

Run `make gen-golden-all` to regenerate the golden test outputs.

## Contributing and license

This library is licensed under [BSD-3-Clause](LICENSE).
For information about how to contribute, see [CONTRIBUTING](CONTRIBUTING.md).

[commodore]: https://syn.tools/commodore/
[asciidoc]: https://asciidoctor.org/
[antora]: https://antora.org/
