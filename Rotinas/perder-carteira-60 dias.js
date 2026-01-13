//instancia de query JS dentro do ERP
var query = getQuery();

//Base query: Clientes que não tiveram vendas nos ultimos 60 dias, desconsiderando Beatriz, Leonardo Pimentel e Sem vendedor (evitando rodar por duplicidade)
query.nativeSelect("SELECT * FROM TGFPAR PAR WHERE PAR.CLIENTE = 'S' AND PAR.CODPARC > 0 AND CODVEND NOT IN (34, 33, 1) AND PAR.CODPARC NOT IN (SELECT DISTINCT CAB.CODPARC FROM TGFCAB CAB WHERE CAB.CODTIPOPER IN (3200, 3205, 3250, 3262) AND CAB.DTNEG < CURRENT_DATE AND CAB.DTNEG > CURRENT_DATE - 60)");

//Definição de array para listagem de clientes a serem atualizados
var array = new Array();

//Execução da query dentro de um loop, ou seja, enquanto houverem resultados
while(query.next()){
    //Preenchendo o array com os códigos de parceiro, por meio da função push
    array.push(query.getString("CODPARC"));
}

//Faz a verificação do tamanho do array
if(array.length > 0){
    //Caso o array tenha tamanho maior que zero, percorreremos o array, item a item para tirar o código do vendedor ao qual ele pertence
    for(i = 0; i < array.length; i++){
        //Fazemos o update do código de vendedor com base no parceiro dentro do array
        query.update("UPDATE TGFPAR set CODVEND = 1 where CODPARC =" + array[i]);
    }
    //Após a opração finalizada, retornamos uma mensagem de sucesso
    mensagem = "Clientes removidos da carteira";
    
}else{
    //Em caso do tamanho ser menor que 0, retornamos uma mensagem de que não foram encontrados registros
    mensagem = "Nenhum cliente a ser removido";
}

