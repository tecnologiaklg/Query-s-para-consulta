//instancia de query JS dentro do ERP
var query = getQuery();

//Pegando a data atual por meio de um parametro JS
var today = new Date();
//Montando a data de hoje no parametro do banco de dados dd/m/yyyy
var date = today.getDate() + '/' + (today.getMonth()) + '/' + today.getFullYear();

query.setParam("DATA", date);

//Base da query: trazer das notas emitidas no periodo vigente o cliente e vendedor
query.nativeSelect("SELECT CODPARC, CODVEND FROM TGFCAB WHERE CODTIPOPER IN (3101, 3202) AND DTNEG = '24/06/2021' ");

//Criação de array para colocar os resultados do select
var array = new Array();

//Loop de execução para enquanto ele encontrar resultados
while(query.next()){
    //Preenchimento do array com o seguinte padrão: Codigo de parceiro, codigo do vendedor
    array.push(query.getString("CODPARC"), query.getString("CODVEND"));
}

//Mensagem de verificação dos registros, para testes
//mensagem = "Registros encontrados: " + array.join(",");

//Logica a ser seguida: O array será preenchido da seguinte forma -> Array["CODPARC", "CODVEND"]
//Sabendo disso, o valor J será o código do vendedor e o valor I do cliente. Para que o update sempre acerte o cliente certo para o vendedor certo
//Posições pares do array serão os códigos dos clientes e as ímpares serão sempre os códigos de vendedor

//Variavel criada para apontar o vendedor do codigo do parceiro
var j = 1;

//Verificação do array feito, se for maior que um, será executado
if(array.length > 0){

    //Loop para percorrer todos os itens do array
    for(i = 0; i < array.length; i++){
        query.setParam("VENDEDOR", array[j]);
        query.setParam("PARCEIRO", array[i]);

        //Query de update do vendedor dentro do cliente, ou seja, mover para a carteira do mesmo
        query.update("UPDATE TGFPAR SET CODVEND = {VENDEDOR} WHERE CODPARC = {PARCEIRO}" );
        //Contador do J para pegar o proximo vendedor, necessitando que sejam apenas em numeros impares
        j += 2;
        //contador do I para pegar o proximo parceiro, pois precisamos que o I sejam apenas em numeros pares
        i++;
    }
    //Mensagem de retorno
    mensagem = "Os clientes foram colocados na carteira!";
}else{
    //Mensagem de retorno
    mensagem = "Nenhuma nota emitida no periodo"
}

