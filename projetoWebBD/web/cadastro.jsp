<%@ page import="config.Conexao" %>
<%@ page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="styless.css">

        <title>Cadastro de Usuário - cadastro.jsp</title>
    </head>
    <body>
   
        <main>
            <h1>Cadastro de usuário</h1>
            <form action="" method="POST">
                <label>Nome:</label>
                <input type="text" name="txtNome">
                <br><br>
               
                <label>Login: </label>
                <input type="text" name="txtLogin">
                <br><br>
               
                <label>Senha: </label>
                <input type="password" name="txtSenha">
                <br><br>
               
                <button type="submit" name="btnCadastrar"> Cadastrar </button>
                <div class="signup-link">
                Já tem uma conta? <a href="index.jsp">Faça Login!</a>
            </div>
            </form>
            
        </main>
       
    </body>
</html>

        <%
           if(request.getParameter("btnCadastrar")!=null){
                //Obter valores informados no Form
                String nomeVar = request.getParameter("txtNome");
                String loginVar = request.getParameter("txtLogin");
                String senhaVar = request.getParameter("txtSenha");
               
                //conexao
                Statement st = null;
                ResultSet rs= null;
                st = new Conexao().conectar().createStatement();                          
                rs = st.executeQuery("SELECT * FROM usuario WHERE login = '"+loginVar +"'");
               
                if (rs.next()){
                    out.print("<script> alert('Usuário já cadastrado!') </script>");
                }
                else{
                    //inserir dados no bd
                    st.executeUpdate("INSERT INTO usuario(nome, login, senha)VALUES ('"+nomeVar+"','"+loginVar+"', '"+senhaVar+"')");            
                    %>
                        <script>
                            alert("Cadastro com sucesso!");
                            window.location.href='index.jsp';
                        </script>
                    <%
                }
            }
        %>