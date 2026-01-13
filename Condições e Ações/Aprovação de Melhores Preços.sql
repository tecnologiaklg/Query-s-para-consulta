/************************************************
Seleciona as linhas que serão geradas
************************************************/
for(var i = 0; i < linhas.length; i++){
var linha = linhas[i];

var vID = linhas[i].getCampo("ID");

var query = getQuery();
query.setParam("pvID", vID);
query.nativeSelect(" SELECT TDD.ID_DET, TDD.ID, TDD.SEQ FROM (SELECT DET.ID_DET, NVL(DET.UN_PRC,0) - NVL(UN_DESC,0) AS MENOR_PRECO, DET.ID, DET.SEQ FROM AD_DETPRC DET WHERE DET.ID = {pvID}) TDD RIGHT JOIN (SELECT MIN(NVL(DET.UN_PRC,0) - NVL(UN_DESC,0)) AS MENOR_PRECO, DET.ID, DET.SEQ FROM AD_DETPRC DET WHERE DET.ID = {pvID} GROUP BY DET.ID, DET.SEQ) MNM ON MNM.ID = TDD.ID AND MNM.SEQ = TDD.SEQ AND MNM.MENOR_PRECO = TDD.MENOR_PRECO ");

var array = new Array();
while(query.next()){
array.push(query.getString("ID_DET"), query.getString("ID"), query.getString("SEQ"));
}

var y = 1
var z = 2

var tamanho = array.length;

if(array.length > 0){

    for(var x = 0; x < tamanho; x++){
        query.setParam("pIDdet", array[x]);
        query.setParam("pID", array[y]);
        query.setParam("pSEQ", array[z]);

        query.update("UPDATE AD_DETPRC SET PRC_AUT = 'S' WHERE ID_DET = {pIDdet} AND ID = {pID} AND SEQ = {pSEQ}");

        x+=2;
        y+=3;
        z+=3;
    }
}else{

    mensagem = "Nenhum preço informado na Lista"
}

}