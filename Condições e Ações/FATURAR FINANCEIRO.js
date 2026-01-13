for(var i = 0; i < linhas.length; i++){
    var linha = linhas[i];

if(linhas[i].getCampo("TIPO") == 'P' || linhas[i].getCampo("TIPO") == 'I') {
if(linhas[i].getCampo("TIPO") == 'I') {    
    //Solicitamos a inclusão de uma linha no financeiro
    var financeiro = novaLinha("TGFFIN");
    //Informamos os campos desejados para incluir o financeiro
    financeiro.setCampo("VLRDESDOB", linhas[i].getCampo("VLRDESDOB"));
    financeiro.setCampo("RECDESP", -1);
    financeiro.setCampo("CODEMP", linhas[i].getCampo("CODEMP"));
    financeiro.setCampo("NUMNOTA", 0);
    financeiro.setCampo("DTNEG", linhas[i].getCampo("DTALT"));
    financeiro.setCampo("CODPARC", linhas[i].getCampo("CODPARC"));
    financeiro.setCampo("CODNAT", 0);
    financeiro.setCampo("CODBCO", 0);
    financeiro.setCampo("CODPROJ", linhas[i].getCampo("CODPROJ"));
    financeiro.setCampo("CODUSU", linhas[i].getCampo("CODUSU"));
    financeiro.setCampo("AD_INVOICE_ID", linhas[i].getCampo("IDINVOICE"));
    financeiro.setCampo("AD_TIPO_INV", '1');
    financeiro.setCampo("AD_IDFINIMP", linhas[i].getCampo("IDFINIMP"));
    financeiro.setCampo("CODTIPTIT", 11);
    financeiro.setCampo("DTVENC", linhas[i].getCampo("DTVENC"));
    financeiro.setCampo("HISTORICO", linhas[i].getCampo("NOTAS"));
    financeiro.setCampo("AD_TXIMP", 'S');
    financeiro.setCampo("AD_FINIMP_TIPO", linhas[i].getCampo("TIPO"));
    //Quando o "save" do registro é acionado,
    //a alteração é feita no Banco de dados.
    //Portanto aqui estamos incluindo um registro na TGFFIN.
    financeiro.save();
    //O que foi gerado
    mensagem = "Foi gerado o título ";
    mensagem += financeiro.getCampo("NUFIN");
    mensagem += " no valor de ";
    mensagem += financeiro.getCampo("VLRDESDOB");
    mensagem += " para a importação.";
} else if(linhas[i].getCampo("AD_TIP_TRANSP") != 'S'){
    //Solicitamos a inclusão de uma linha no financeiro
var financeiro = novaLinha("TGFFIN");
//Informamos os campos desejados para incluir o financeiro
financeiro.setCampo("VLRDESDOB", linhas[i].getCampo("VLRDESDOB"));
financeiro.setCampo("RECDESP", -1);
financeiro.setCampo("CODEMP", linhas[i].getCampo("CODEMP"));
financeiro.setCampo("NUMNOTA", 0);
financeiro.setCampo("DTNEG", linhas[i].getCampo("DTALT"));
financeiro.setCampo("CODPARC", linhas[i].getCampo("CODPARC"));
financeiro.setCampo("CODNAT", 0);
financeiro.setCampo("CODBCO", 0);
financeiro.setCampo("CODPROJ", linhas[i].getCampo("CODPROJ"));
financeiro.setCampo("CODUSU", linhas[i].getCampo("CODUSU"));
financeiro.setCampo("AD_INVOICE_ID", linhas[i].getCampo("IDINVOICE"));
financeiro.setCampo("AD_TIPO_INV", '1');
financeiro.setCampo("AD_VLR_USD", linhas[i].getCampo("VLR_USD"));
financeiro.setCampo("AD_IDFINIMP", linhas[i].getCampo("IDFINIMP"));
financeiro.setCampo("CODTIPTIT", 7);
financeiro.setCampo("DTVENC", linhas[i].getCampo("DTVENC"));
financeiro.setCampo("HISTORICO", linhas[i].getCampo("NOTAS"));
financeiro.setCampo("AD_FINIMP_TIPO", linhas[i].getCampo("TIPO"));
//Quando o "save" do registro é acionado,
//a alteração é feita no Banco de dados.
//Portanto aqui estamos incluindo um registro na TGFFIN.
financeiro.save();
//O que foi gerado
mensagem = "Foi gerado o título ";
mensagem += financeiro.getCampo("NUFIN");
mensagem += " no valor de ";
mensagem += financeiro.getCampo("VLRDESDOB");
mensagem += " para a importação.";
} else {
 //Solicitamos a inclusão de uma linha no financeiro
 var financeiro = novaLinha("TGFFIN");
 //Informamos os campos desejados para incluir o financeiro
 financeiro.setCampo("VLRDESDOB", linhas[i].getCampo("VLRDESDOB"));
 financeiro.setCampo("RECDESP", -1);
 financeiro.setCampo("CODEMP", linhas[i].getCampo("CODEMP"));
 financeiro.setCampo("NUMNOTA", 0);
 financeiro.setCampo("DTNEG", linhas[i].getCampo("DTALT"));
 financeiro.setCampo("CODPARC", linhas[i].getCampo("CODPARC"));
 financeiro.setCampo("CODNAT", 0);
 financeiro.setCampo("CODBCO", 0);
 financeiro.setCampo("CODPROJ", linhas[i].getCampo("CODPROJ"));
 financeiro.setCampo("CODUSU", linhas[i].getCampo("CODUSU"));
 financeiro.setCampo("AD_INVOICE_ID", linhas[i].getCampo("IDINVOICE"));
 financeiro.setCampo("AD_INV_ID_SERV", linhas[i].getCampo("IDINVOICE"));
 financeiro.setCampo("AD_TIPO_INV", '2');
 financeiro.setCampo("AD_VLR_SERV", linhas[i].getCampo("VLR_USD"));
 financeiro.setCampo("AD_VLR_USD", linhas[i].getCampo("VLR_USD"));
 financeiro.setCampo("AD_IDFINIMP", linhas[i].getCampo("IDFINIMP"));
 financeiro.setCampo("CODTIPTIT", 7);
 financeiro.setCampo("DTVENC", linhas[i].getCampo("DTVENC"));
 financeiro.setCampo("HISTORICO", linhas[i].getCampo("NOTAS"));
 financeiro.setCampo("AD_REF_IMPORT", linhas[i].getCampo("AD_REF_IMPORT"));
 financeiro.setCampo("AD_REF_INVOICE", linhas[i].getCampo("AD_REF_INVOICE"));
 financeiro.setCampo("AD_FINIMP_TIPO", linhas[i].getCampo("TIPO"));
 //Quando o "save" do registro é acionado,
 //a alteração é feita no Banco de dados.
 //Portanto aqui estamos incluindo um registro na TGFFIN.
 financeiro.save();
 //O que foi gerado
 mensagem = "Foi gerado o título ";
 mensagem += financeiro.getCampo("NUFIN");
 mensagem += " no valor de ";
 mensagem += financeiro.getCampo("VLRDESDOB");
 mensagem += " para a importação.";
}
}

}
