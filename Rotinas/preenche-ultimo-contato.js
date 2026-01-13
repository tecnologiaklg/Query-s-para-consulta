var query = getQuery();

//bloco responsável por pegar a data de ultimo contato automaticamente
var today = new Date();
var date = today.getDate() + '/' + (today.getMonth() + 1) + '/' + today.getFullYear();

//Bloco responsável por pegar o usuário logado
var codUsuario = getUsuarioLogado();

//mensagem = "Cod do usuário: " + codUsuario;

//setando parametros para trazer nome de usuário
query.setParam("CODIGOUSUARIO", codUsuario);

//Variavel para armazenar o nome de usuário
var nomeUsuario;

//Seleciona com base no código de usuário o nome do mesmo
query.nativeSelect("select NOMEUSU from TSIUSU where CODUSU = {CODIGOUSUARIO} ");

//Passando o resultado da query para a variavel de nome
while(query.next()){
    nomeUsuario = query.getString("NOMEUSU");
}

//mensagem = "Nome do usuário: " + nomeUsuario;

//Para percorrer os itens selecionados
for(var i = 0; i < 1; i++){
    //mensagem = "entrou aqui";
    var linha = linhas[i];
        
    //Setando os campos na base de dados
         linha.setCampo("AD_DATA_ULTIMO_CONTATO", date);
         linha.setCampo("AD_USU_ULTIMO_CONTATO", nomeUsuario);
    //Retorno ao usuário
          mensagem = "Data do ultimo contato alterada para hoje!";
       
}