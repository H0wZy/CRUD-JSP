<%@ page import="config.Conexao" %>
<%@ page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String idCurso = request.getParameter("id");
    //converter variavel para int
    int idCursoI = Integer.parseInt(idCurso);
    
    Statement st = null;
    ResultSet rs = null;
    st = new Conexao().conectar().createStatement();
    
    st.execute("DELETE FROM curso WHERE idCurso='"+idCursoI+"'");
    
%>

<script>
    alert("Curso excluído com sucesso");
    window.location.href = "painelAdmCurso.jsp";
</script>