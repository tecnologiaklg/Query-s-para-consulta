/************************************************
Seleciona as linhas que serão geradas
**************************************************/
for(var i = 0; i < linhas.length; i++){
var linha = linhas[i];

var vUF = linhas[i].getCampo("UF_P");
var IDcalc = linhas[i].getCampo("ID");

var query = getQuery();
query.setParam("pIDcalc", IDcalc);
query.nativeSelect("SELECT ITE.CODPROD, ITE.QTD_MIN FROM AD_CALMIN CAL LEFT JOIN AD_ITEMIN ITE ON CAL.ID = ITE.ID WHERE CAL.ID = {pIDcalc}");

var array = new Array();
while(query.next()){
array.push(query.getString("CODPROD"), query.getString("QTD_MIN"));    
}

var tamanho = array.length;

if(vUF == 'SP') {
    var k = 1
    for(var j = 0; j < tamanho; j++){
    var upQuery = getQuery();
    upQuery.setParam("pCOD", array[j]);
    upQuery.setParam("pQTD", array[k]);
    upQuery.update("UPDATE TGFPRO SET AD_QTDMIN_MAT = {pQTD} WHERE CODPROD = {pCOD}");
    j++;
    k+=2;
    }
    //Mensagem de retorno
    mensagem = "Foram alterados " + (tamanho / 2) + " itens da quantidade min. de " + vUF;

} else if (vUF == 'PE') {
    var k = 1
    for(var j = 0; j < tamanho; j++){
    var upQuery = getQuery();
    upQuery.setParam("pCOD", array[j]);
    upQuery.setParam("pQTD", array[k]);
    upQuery.update("UPDATE TGFPRO SET AD_QTDMIN_PER = {pQTD} WHERE CODPROD = {pCOD}");
    j++;
    k+=2;
    }
    //Mensagem de retorno
    mensagem = "Foram alterados " + (tamanho / 2) + " itens da quantidade min. de " + vUF;

} else {
    var k = 1
    for(var j = 0; j < tamanho; j++){
    var upQuery = getQuery();
    upQuery.setParam("pCOD", array[j]);
    upQuery.setParam("pQTD", array[k]);
    upQuery.update("UPDATE TGFPRO SET AD_QTDMIN_SC = {pQTD} WHERE CODPROD = {pCOD}");
    j++;
    k+=2;
    }
    //Mensagem de retorno
    mensagem = "Foram alterados " + (tamanho / 2) + " itens da quantidade min. de " + vUF;

}

}



