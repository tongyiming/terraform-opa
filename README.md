## 使用介绍
### update opa pliecies
`git submodule update --init`

### run all opa rules
* `terraform plan -out=plan.tfplan`
* `terraform show -json  plan.tfplan > ./tfplan.json`
* `conftest test ./tfplan.json -o table --all-namespaces -p opa-policies` or `conftest test ./tfplan.json -o github --all-namespaces -p opa-policies`

## OPA门禁演示
### 提交不符合OPA规则的代码
![](https://github.com/tongyiming/terraform-opa/blob/main/imgs/opa-tf-code.jpg)

### 通过在pull requests中设置lable触发OPA门禁流水线
![](https://github.com/tongyiming/terraform-opa/blob/main/imgs/opa-pr.jpg)

### OPA规则检测失败
![](https://github.com/tongyiming/terraform-opa/blob/main/imgs/opa-result.jpg)
