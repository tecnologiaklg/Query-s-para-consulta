
//Pegando o parametro previamente definido para armazenar o codigo do vendedor
adStatus = getParam("STATUS");
adDtap = getParam("DTAPROV");

//mensagem = "cód de vendedor: " + codUsuario;

//Para percorrer os itens selecionados
for(var i = 0; i < 1; i++){
    //mensagem = "entrou aqui";
    var linha = linhas[i];

//Verificando qual é o código do item selecionado
    var check = linha.getCampo("AD_NUM_OS");

    //mensagem = "Numero da OS selecionado: " + check;

    //Verifica se o vendedor poderá alterar o dono do orçamento
    if(check > 0){

        var query = getQuery();
        query.setParam("STATUS", adStatus);
        query.setParam("DTAPROV", adDtap);
        query.setParam("OS", check);
        query.update("UPDATE TGFCAB SET AD_STAT_OS = {STATUS}, AD_DT_APROV = {DTAPROV} WHERE NUNOTA = {OS}");
    }
    else{
    mensagem = "Não é possível informar OS, apenas as operações 2109 e 2108 podem ser utilizadas";
    }

}