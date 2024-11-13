<%@ page import="config.Conexao" %>
<%@ page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="styless.css">
        <title>Login Sistema - index.jsp</title>
    </head>
    <body>
        <form action="" method="post">
            <label>Login: </label>
            <input type="text" name="txtlogin">
            <br><br>
            <label>Senha: </label>
            <input type="password" name="txtsenha">
            <br>
            <%
           //obtém os valores dos inputs
           String loginVar = request.getParameter("txtlogin");
           String senhaVar = request.getParameter("txtsenha");
           
           Statement st = null;//executar a consulta. Statement permite executar SQL (insert, select...)  
           ResultSet rs= null; // armazenar a consulta
           
           //criar a conexao com o bd.
           st = new Conexao().conectar().createStatement();
           
           // executa a consulta na tabela usuario, conforme o login e senha informado
           rs= st.executeQuery("SELECT * FROM usuario WHERE login='"+loginVar+"' AND senha='"+senhaVar+"'");
           
           
           int i = 0;// Inicializa o contador que verifica a qtd de registro.
           String nomeUsuario= null; // variavel que vai receber o nome do usuario logado
           
           //verifica se há pelo menos um registro
           if (rs.next()){
                i=1; //Indica que encontrou pelo menos um usuario
                nomeUsuario = rs.getString(2); //Captura o nome do usuario encontrado
           }
           
           // verifica se os campos estão vazio
           if(loginVar == null || senhaVar == null ){
                out.print("Preencha os dados");
           }
           // verifica se retornou algum usuario
           else if(i>0){
                //armazenar o nome do usuario em uma sessão
                session.setAttribute("nomeUsuario", nomeUsuario);
                //redirecionar para a página painelAdm.jsp
                response.sendRedirect("painelAdm.jsp");
           }
           //não localizou o usuario informado
           else{
                out.print("Dados incorretos");
           }
        %>
            <br>
            <div class="signup-link">
                Não tem uma conta? <a href="cadastro.jsp">Cadastre-se!</a>
            </div>
            <br>
            <button type="submit">Entrar</button>
        </form>
       
        
    </body>
</html>
