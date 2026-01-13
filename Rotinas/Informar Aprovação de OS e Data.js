
//Pegando o parametro previamente definido para armazenar o codigo do vendedor
adStatus = getParam("STATUS");

//Retorna a data de hoje
var today = new Date();
var date = today.getDate() + '/' + (today.getMonth() + 1) + '/' + today.getFullYear();

//Para percorrer os itens selecionados
for(var i = 0; i < 1; i++){
    //mensagem = "entrou aqui";
    var linha = linhas[i];

    //Retorna o Status da OS 
    var query = getQuery();
    query.nativeSelect("SELECT AD_STAT_OS FROM TGFCAB WHERE NUNOTA ="+linha.getCampo("AD_NUM_OS"));

    //mensagem = "Codigo de vendedor do item selecionado: " + check;

    //Verifica se o Status está preenchido antes de realizar as alterações
    if(query == null){
          var query2 = getQuery();
          query2.update("UPDATE TGFCAB SET AD_STAT_OS = {adStatus} AND AD_DT_APROV = {date} WHERE NUNOTA ="+linha.getCampo("AD_NUM_OS"));
          mensagem = "Status de Aprovação informado com Sucesso";
    }
    else{
        mensagem = "Não é possível alterar Aprovação já realizada antetriormente.";
    }

       
}