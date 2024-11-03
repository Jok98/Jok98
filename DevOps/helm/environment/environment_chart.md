# Environment Chart
Contains the `charts` for the different `environments`(ex. dev-env, prod-env).<br>
These `Charts.yaml` file contains `dependencies` on both the `common` chart and the charts in the `components` folder<br>
The `template folder` contains a `secrets.yaml template` to create `environment-specific credentials as Secrets`.<br>
It is based on the named template for Secrets from the common chart and looks like this:
```yaml
{{- template "common.secrets" . -}}
```