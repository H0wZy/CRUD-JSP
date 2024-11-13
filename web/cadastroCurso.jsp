<%@ page import="config.Conexao" %>
<%@ page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="stylesss.css">

        <title>Cadastrar Curso</title>
    </head>
    <body>

        <main>
            <h1>Cadastro de curso</h1>
            <form action="cadastroCurso.jsp" method="POST">
                <label>Nome:</label>
                <input type="text" name="txtNomeCurso">
                <br><br>
                <label for="descricao">Descrição: </label>
                <textarea id="descricao" name="txtDescricao" rows="4" cols="50" placeholder="Descrição do curso."></textarea>

                <br><br>
                <label for="cargaHoraria">Carga Horária: </label>
                <input type="text" name="txtCargaHoraria">

                <br><br>

                <button type="submit" name="btnCadastrarCurso"> Cadastrar </button>
            </form>

        </main>

    </body>
</html>

<%
    if (request.getParameter("btnCadastrarCurso") != null) {
        //Obter valores informados no Form
        String nomeCursoVar = request.getParameter("txtNomeCurso");
        String descCursoVar = request.getParameter("txtDescricao");
        String cargaHorariaCursoVar = request.getParameter("txtCargaHoraria");

        //conexao
        Statement st = null;
        ResultSet rs = null;
        st = new Conexao().conectar().createStatement();
        rs = st.executeQuery("SELECT * FROM curso WHERE nomeCurso = '" + nomeCursoVar + "'");

        if (rs.next()) {
            out.print("<script> alert('Curso já cadastrado!') </script>");
        } else {
            //inserir dados no bd
            st.executeUpdate("INSERT INTO curso(nomeCurso, descricao, cargaHoraria)VALUES ('" + nomeCursoVar + "','" + descCursoVar + "', '" + cargaHorariaCursoVar + "')");
%>
<script>
    alert("Curso cadastrado com sucesso!");
    window.location.href = 'painelAdmCurso.jsp';
</script>
<%
        }
    }
%>