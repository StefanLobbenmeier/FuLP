# Selbstkontrollaufgaben

## 6.4
public void sum() #Arithmetic(>1) : {} {
    product() (
        (t=<AddOperator> { jjtThis.operators.add(t.image); })
        product()
        )*
}