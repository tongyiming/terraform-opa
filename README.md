## update opa pliecies
`git submodule update --remote`

## run all opa rules
* `terraform plan -out=plan.tfplan`
* `terraform show -json  plan.tfplan > ./opa.json`
* `conftest test ./opa.json -o table --all-namespaces -p opa-policies` or `conftest test ./opa.json -o github --all-namespaces -p opa-policies`