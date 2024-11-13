<%@ page import="config.Conexao" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>teste de conexão</title>
    </head>
    <body>
        <%
            Conexao conexao = new Conexao();
            Connection conn = conexao.conectar();
            if (conn != null && !conn.isClosed()) {
                
                out.print("<p> Conexão realizada com sucesso. </p>");
                conn.close();
                out.print("<p> Conexão fechada com sucesso. </p>  ");
            }else {
                out.print("<p> Não foi possível estabelecer uma conexão. </p> ");
            }

        %>
    </body>
</html>