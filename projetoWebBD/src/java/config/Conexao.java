package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexao {

    public Connection conectar() throws SQLException, ClassNotFoundException{
        
     Class.forName("com.mysql.cj.jdbc.Driver");   
     
     String url = "jdbc:mysql://localhost:3306/formacaojava";
     String user = "root";
     String password = "";
     
     return DriverManager.getConnection (url,user, password );
    }
}