//Fazer filtro personalizado no ERP e selecionar dos resultados quais desejam ser executados

//percorre item a item dos selecionados
for(var i = 0; i < linhas.length; i++){
    //define o parametro para percorrer os registros
    var linha = linhas[i];

        //Seta o campo codvend para o vendedor 1, que seria sem vendedor
        linha.setCampo("CODVEND","1");
        //Retorna mensagem após o sucesso
         mensagem = "Vendedores Alterados";
}
