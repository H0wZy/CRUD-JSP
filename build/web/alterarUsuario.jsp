<%@ page import="config.Conexao" %>
<%@ page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="styless.css"/>
<%
    String idUsuario = request.getParameter("id");
    //converter a variavel para inteiro  
    int idUsuarioI = Integer.parseInt(idUsuario);
   
   //gerar a conexao com o BD
    Statement st = null;
    ResultSet rs = null;
    st = new Conexao().conectar().createStatement();

    // selecionar o usuario da URL
    rs= st.executeQuery("SELECT * FROM usuario WHERE idUsuario="+idUsuarioI);

    if (rs.next())
    { %>

        <form action="" method="POST">
            <label>Nome:</label>
            <input type="text" name="txtNome" value="<%= rs.getString(2)%>">
            <br><br>
            <label>Login: </label>
            <input type="text" name="txtLogin" value="<%= rs.getString(3)%>">
            <br><br>
            <label>Senha: </label>
            <input type="text" name="txtSenha" value="<%= rs.getString(4)%>">
            <br><br>
            <button type="submit" name="btnAlterar"> Alterar </button>
        </form>
  <% }
   
           if(request.getParameter("btnAlterar")!=null){
                //Obter valores informados no Form
                String nomeVar = request.getParameter("txtNome");
                String loginVar = request.getParameter("txtLogin");
                String senhaVar = request.getParameter("txtSenha");

                st.executeUpdate("UPDATE usuario SET nome='"+nomeVar+"', login='"+loginVar+"',senha='"+senhaVar+"' where idUsuario =" +idUsuarioI);                                
        %>
 
                <script>
                   alert("Usuário alterado com sucesso");
                   window.location.href="painelAdm.jsp";
              </script>
 
 
       <% }%>