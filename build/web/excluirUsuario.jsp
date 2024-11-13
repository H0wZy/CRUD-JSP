<%@ page import="config.Conexao" %>
<%@ page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String idUsuario = request.getParameter("id");
    //converter variavel para int
    int idUsuarioI = Integer.parseInt(idUsuario);
    
    Statement st = null;
    ResultSet rs = null;
    st = new Conexao().conectar().createStatement();
    
    st.execute("DELETE FROM usuario WHERE idUsuario='"+idUsuarioI+"'");
    
%>

<script>
    alert("Usuario excluído com sucesso");
    window.location.href = "painelAdm.jsp";
</script>