for (var i = 0; i < linhas.length; i++) {
    var linha = linhas[i];
    var id = linha.getCampo("ID");
    var seq = linha.getCampo("SEQ");
    var codParc = linha.getCampo("CODPARC");
    var codCont = linha.getCampo("CODCONTATO");
    var relat = linha.getCampo("RELATO");
    var notaPreenc = linha.getCampo("NUNOTA");

if(linhas[i].getCampo("STATUS") == 'O' && (!notaPreenc || notaPreenc < 0)) {

        var hoje = new java.util.Date();
        var newCab = novaLinha("TGFCAB");
        newCab.setCampo("CODEMP", 5); // KLG COM SC (MAIS UTILIZADA)
        newCab.setCampo("CODTIPOPER", 3100); // PEDIDO DE COMPRA
        newCab.setCampo("CODPARC", codParc); // CÓD. DO CLIENTE
        newCab.setCampo("DTNEG", hoje); // DATA ATUAL
        newCab.setCampo("NUMNOTA", 3100); // NUM DEFINIDO APENAS PARA PREENCHIMENTO OBRIG.
        newCab.setCampo("CODCONTATO", codCont); // CONTATO DO CRM
        newCab.setCampo("CODVEND", 144); // PADRÃO DE ATENDENTE
        newCab.setCampo("AD_ATENDENTE", 144); // PADRÃO DE ATENDENTE
        newCab.setCampo("CODTIPVENDA", 18); // PADRÃO BOLETO 10 DDL
        newCab.setCampo("AD_RETORNO_VEND", relat); // O QUE FOI CONVERSADO, OS PROD. OU SERV. PARA O ORÇ.


        newCab.save();

        var numOrc = newCab.getCampo("NUNOTA");

        var query = getQuery();
        query.setParam("ID", id);
        query.setParam("SEQ", seq);
        query.setParam("NUMORC", numOrc);
        query.update("UPDATE AD_ATDCRM SET NUNOTA = {NUMORC} WHERE ID = {ID} AND SEQ = {SEQ}");

} else {
    mensagem = "Faturar apenas com Status de 'Orçamento' e Não Faturado Ainda!";
    
}
}