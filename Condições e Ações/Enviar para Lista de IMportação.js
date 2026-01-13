/************************************************
Seleciona as linhas que serão geradas
**************************************************/
for(var i = 0; i < linhas.length; i++){
var linha = linhas[i];

var idList = getParam("ID_LIST");

var Query = getQuery();

//Parametro
Query.setParam("pID", linhas[i].getCampo("ID"));
Query.setParam("pSEQ", linhas[i].getCampo("SEQ"));

//Select
Query.nativeSelect("SELECT DPN.VLR_UNIT FROM AD_DETPNV DPN WHERE DPN.ID = {pID} AND DPN.SEQ = {pSEQ}");

//BUscando e transformando os valores em Variaveis para serem trabalhadas
while(Query.next()){
var VlrUnit = Query.getDouble("VLR_UNIT");
var CodParc = Query.getInt("CODPARC");
}


if(linhas[i].getCampo("APROVEIT") == 'S') {

var Lista = novaLinha("AD_ITELIS");
Lista.setCampo("ID", idList);
Lista.setCampo("CODPROD", linhas[i].getCampo("CODPROD"));
Lista.setCampo("QTD_SUG", linhas[i].getCampo("QTD"));
Lista.save();


var Detalhe = novaLinha("AD_DETPRC");
Detalhe.setCampo("ID", Lista.getCampo("ID"));
Detalhe.setCampo("SEQ", Lista.getCampo("SEQ"));
Detalhe.setCampo("UN_PRC", VlrUnit);
Detalhe.setCampo("CODPARC", CodParc);
Detalhe.save();



} else {mensagem = "Você esta tentando lançar um produto que não foi Aproveitado. Verifique!";
}

}












