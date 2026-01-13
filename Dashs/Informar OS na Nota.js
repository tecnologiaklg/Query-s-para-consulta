
//Pegando o parametro previamente definido para armazenar o codigo do vendedor
numOS = getParam("OS");

//mensagem = "cód de vendedor: ";

//Para percorrer os itens selecionados
for(var i = 0; i < 1; i++){
    //mensagem = "entrou aqui";
    var linha = linhas[i];

    //Verificando qual é o código do item selecionado
    var check = linha.getCampo("AD_CODTIPOPER");

    //mensagem = "Codigo do item selecionado: " + check;

    //Verifica se o item poderá alterado
    if(check == 2108 || check == 2109){
         linha.setCampo("AD_NUM_OS", numOS);
          mensagem = "Informado OS";
    }
    else{
        mensagem = "Não é possível informar OS, apenas as operações 2109 e 2108 podem ser utilizadas";
    }

       
}