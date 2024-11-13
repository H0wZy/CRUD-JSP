<%@ page import="config.Conexao" %>
<%@ page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="styless.css"/>
<%
    String idCurso = request.getParameter("id");
    //converter a variavel para inteiro  
    int idCursoI = Integer.parseInt(idCurso);

    //gerar a conexao com o BD
    Statement st = null;
    ResultSet rs = null;
    st = new Conexao().conectar().createStatement();

    // selecionar o usuario da URL
    rs = st.executeQuery("SELECT * FROM curso WHERE idCurso=" + idCursoI);

    if (rs.next()) {%>

<form action="" method="POST">
    <label>Nome:</label>
    <input type="text" name="txtNomeCurso" value="<%= rs.getString(2)%>">
    <br><br>
    <label for="descricao">Descrição: </label>
    <textarea id="descricao" name="txtDescricao" rows="4" cols="50" placeholder="Descrição do curso."><%= rs.getString(3)%></textarea>

    <br><br>
    <label for="cargaHoraria">Carga Horária: </label>
    <input type="text" name="txtCargaHoraria" value="<%= rs.getString(4)%>">

    <br><br>
    <button type="submit" name="btnAlterarCurso"> Alterar </button>
</form>
<% }

    if (request.getParameter("btnAlterarCurso") != null) {
        //Obter valores informados no Form
        String nomeCursoVar = request.getParameter("txtNomeCurso");
        String descCursoVar = request.getParameter("txtDescricao");
        String cargaHorariaCursoVar = request.getParameter("txtCargaHoraria");

        st.executeUpdate("UPDATE curso SET nomeCurso='" + nomeCursoVar + "', descricao='" + descCursoVar + "',cargaHoraria='" + cargaHorariaCursoVar + "' where idCurso =" + idCursoI);
%>

<script>
    alert("Curso alterado com sucesso");
    window.location.href = "painelAdmCurso.jsp";
</script>


<% }%>