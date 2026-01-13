for(var i = 0; i <linhas.length; i++){
var linha = linhas[i];

vNF = getParam("NOTA");

var query = getQuery();

query.setParam("pNF", vNF);

query.update("UPDATE TGFFIN SET NUMNOTA = {pNF} WHERE NUFIN ="+linhas[i].getCampo("NUFIN"));

mensagem = 'Nº de NF Alterado para ' + vNF;

}