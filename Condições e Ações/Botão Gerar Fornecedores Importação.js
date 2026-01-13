for(var i = 0; i < linhas.length; i++){
    var linha = linhas[i];

    
var iteList = getQuery();

iteList.setParam("pEmp",linhas[i].getCampo("CODEMP"));

iteList.nativeSelect("SELECT DISTINCT(FIP.CODPARC) AS CODPARC, FIP.CODPROJ AS CODPROJ FROM AD_FINIMP FIP WHERE FIP.TIPO = 'P' AND FIP.CODPROJ =  ");
//BUscando e transformando os valores em Variaveis para serem trabalhadas
while(iteList.next()){
array.push(iteList.getString("CODPARC"), iteList.getString("CODPROJ"));
}

var k = 1;

var tamanho = array.length;

for(var j = 0; j < tamanho; j++){
var FORNECEDOR = novaLinha("AD_FORNECEDORES");

FORNECEDOR.setCampo("CODPARC", array[j]);
FORNECEDOR.setCampo("CODPROJ", array[k]);

j++;
k+=2;

}

mensagem = "Foram Incluidos: " + (tamanho / 2) + " fornecedores.";


}