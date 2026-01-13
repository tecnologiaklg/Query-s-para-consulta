for(var i = 0; i < linhas.length; i++){
    var linha = linhas[i];

if(linhas[i].getCampo("APROVACAO") == 'A') 
{
    //Solicitamos a inclusão de uma linha no requisicao
    var requisicao = novaLinha("TGFCOT");
    //Informamos os campos desejados para incluir o requisicao
    requisicao.setCampo("AD_REQUISITANTE", linhas[i].getCampo("REQUISITANTE"));
    requisicao.setCampo("AD_REQUISIACAO", linhas[i].getCampo("REQUISIACAO"));
    requisicao.setCampo("AD_MOT_REQ", linhas[i].getCampo("MOT_REQ"));
    requisicao.setCampo("AD_DT_NECES", linhas[i].getCampo("DT_NECESS"));
    requisicao.setCampo("AD_ID_REQ", linhas[i].getCampo("ID_REQCOM"));
    requisicao.setCampo("SITUACAO", 'A');
    requisicao.setCampo("CODUSURESP", getUsuarioLogado());
    //Quando o "save" do registro é acionado,
    //a alteração é feita no Banco de dados.
    //Portanto aqui estamos incluindo um registro na TGFFIN.
    requisicao.save();
    //O que foi gerado
    mensagem = "Foi gerado a Cotação ";
    mensagem += requisicao.getCampo("NUMCOTACAO");
    mensagem += " no prazo de ";
    mensagem += requisicao.getCampo("AD_DT_NECES");

}

}