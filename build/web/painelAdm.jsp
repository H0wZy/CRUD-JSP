<%@ page import="config.Conexao" %>
<%@ page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="styless.css">

        <title>Painel ADM - USUÁRIO</title>
        <style>
/* Estilos gerais da navbar */
.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 20px;
    background-color: #000;
    font-family: Arial, sans-serif;
    color: #fff;
}

.navbar a {
    text-decoration: none;
    color: #fff;
    padding: 8px 12px;
}

.navbar a:hover {
    color: #d4ac0d;
}

.navbar-brand {
    margin-right: 20px;
}

.navbar-left {
    display: flex;
    align-items: center;
}

.navbar-text {
    display: flex;
    align-items: center;
    gap: 10px;
}

.dropdown {
    position: relative;
}

.dropdown-content {
    display: none;
    background-color: #333;
    position: absolute;
    padding: 5px;
    top: 100%;
    left: 0;
    right: 0;
    box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
    z-index: 1;
    line-height: 2; /* Aumenta o espaço entre as opções verticalmente */
}


.dropdown:hover .dropdown-content {
    display: block;
}

.hamburger {
    display: none;
    font-size: 24px;
    cursor: pointer;
}

/* Menu para dispositivos móveis */
.mobile-menu {
    display: none;
    flex-direction: column;
    background-color: #333;
    padding: 10px;
    position: absolute;
    top: 60px;
    left: 0;
    right: 0;
    z-index: 10;
}

.mobile-menu.open {
    display: flex;
}

.mobile-menu a {
    padding: 10px;
    border-bottom: 1px solid #444;
    color: #fff;
}

/* Media Query para telas pequenas (menos de 542px) */
@media (max-width: 542px) {
    .navbar-left {
        display: none; /* Esconde a parte do menu normal */
    }

    .navbar-text {
        display: none; /* Esconde "Olá, Usuário" */
    }

    .dropdown {
        display: none; /* Esconde o dropdown "Gerenciar" */
    }

    .hamburger {
        display: block; /* Mostra o ícone do menu hamburguer */
    }

    .mobile-menu a {
        padding: 12px;
        text-align: center;
    }
}

/* Alinha o menu de "Gerenciar" e o texto de usuário à direita */
.navbar-right {
    display: flex;
    justify-content: flex-end;
    align-items: center;
}

        </style>

        <script>
            function toggleMenu() {
                const mobileMenu = document.getElementById("mobileMenu");
                mobileMenu.classList.toggle("open");
                const hamburgerIcon = document.querySelector(".hamburger i");
                // Alterna o ícone do hambúrguer para o "X" quando o menu abrir
                if (mobileMenu.classList.contains("open")) {
                    hamburgerIcon.classList.remove("bi-list");
                    hamburgerIcon.classList.add("bi-x");
                } else {
                    hamburgerIcon.classList.remove("bi-x");
                    hamburgerIcon.classList.add("bi-list");
                }
            }
        </script>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    </head>
    <body>
        <header>
            <nav class="navbar">
                <div class="navbar-left">
                    <a href="#" class="navbar-brand">Painel Usuário</a>
                </div>

                <!-- Esta div agora contém a parte direita do menu, incluindo "Olá, Usuário" e o dropdown -->
                <div class="navbar-right">
                    <div class="navbar-text">
                        <span>Olá, <%= (String) session.getAttribute("nomeUsuario")%>!</span>
                    </div>

                    <!-- Dropdown para gerenciar, aparece ao lado de "Olá, Usuário" -->
                    <div class="dropdown">
                        <a href="#" class="dropbtn">Gerenciar ▾</a>
                        <div class="dropdown-content">
                            <a href="painelAdm.jsp">Usuário</a>
                            <a href="painelAdmCurso.jsp">Curso</a>
                            <a href="logout.jsp">Sair</a>
                        </div>
                    </div>
                </div>

                <!-- Ícone de menu hamburguer para dispositivos móveis -->
                <div class="hamburger" onclick="toggleMenu()">
                    <i class="bi bi-list"></i>
                </div>
            </nav>

            <!-- Menu hambúrguer para dispositivos móveis -->
            <div class="mobile-menu" id="mobileMenu">
                <a href="painelAdm.jsp">Usuário</a>
                <a href="painelAdmCurso.jsp">Curso</a>
                <a href="logout.jsp">Sair</a>
            </div>
        </header>

        <main>
            <div class="profile-section">
                <div class="profile-picture">
                    <!-- Adicione uma imagem de perfil (URL ou estática) -->
                    <img src="img/user.webp" alt="Foto do usuário" style="width: 100px; height: 100%; border-radius: 50%; border: 1px solid black">
                </div>
                <div class="username">
                    <%= (String) session.getAttribute("nomeUsuario")%>
                </div>
            </div>

            <form action="" method="post">
                <label>Pesquisar por nome: </label>
                <input type="text" name="txtName">
                <button type="submit" name="buscar">Buscar</button>
            </form> 
            <a href="cadastro.jsp"> <button type="button" name="cadastrar">Cadastrar novo usuário</button> </a>
            <table class="table table-bordered mt-5 w-75 mx-auto">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>Login</th>
                        <th>Senha</th>
                        <th colspan="2" class="text-center" style="text-align: center;">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String nome = request.getParameter("txtName");
                        Statement st = null;
                        ResultSet rs = null;

                        st = new Conexao().conectar().createStatement();
                        if (nome != null) {
                            rs = st.executeQuery("SELECT * FROM usuario WHERE  nome LIKE '%" + nome + "%' ORDER BY nome ASC");
                        } else {
                            rs = st.executeQuery("SELECT * FROM usuario");
                        }
                        while (rs.next()) {
                            out.print("<tr>");
                            out.print("<td>" + rs.getString(1) + "</td>");
                            out.print("<td>" + rs.getString(2) + "</td>");
                            out.print("<td>" + rs.getString(3) + "</td>");
                            out.print("<td>" + rs.getString(4) + "</td>");
                            out.print("<td> <a href='alterarUsuario.jsp?id=" + rs.getString(1) + "'> <button class='action-btn edit-btn'><i class='bi bi-pencil-square'></i>Alterar</button> </a></td>");
                            out.print("<td> <a href='excluirUsuario.jsp?id=" + rs.getString(1) + "'> <button class='action-btn delete-btn'><i class='bi bi-trash-fill'></i>Excluir</button> </a> </td>");
                            out.print("</tr>");
                        }
                    %>
                </tbody>
            </table>  
        </main>

    </body>
</html>
