const express = require('express');
const app = express();
const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'root',
  database: '5to_BetGambler',
});

app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));

// Ruta para registrar un nuevo usuario
app.post('/Registrar', (req, res) => {
  const userData = req.body;

  // Consulta SQL para verificar si el usuario ya existe
  const checkUserQuery = `SELECT * FROM Usuario WHERE dni = '${userData.dni}'`;

  connection.query(checkUserQuery, (error, results) => {
    if (error) {
      console.error('Error al verificar el usuario existente:', error);
      return res.status(500).send('Error en el servidor.');
    }

    if (results.length > 0) {
      return res.status(409).send('El usuario ya está registrado.');
    }

    // Consulta SQL para insertar el nuevo usuario
    const insertUserQuery = `
    CALL AltaUsuario('${userData.contrasena}', '${userData.nombre}','${userData.apodo}', '${userData.dni}', '${userData.email}', ${userData.edad}, '${userData.nacimiento}')`;

    connection.query(insertUserQuery, (error) => {
      if (error) {
        console.error('Error al insertar el usuario en la base de datos:', error);
        return res.status(500).send('Error en el servidor.');
      }
      return res.redirect('/index.html');
    });
  });
});




app.get('/index.html', (req, res) => {
    
    res.send('¡Bienvenido a la página principal!');
  });
  
app.listen(3000, () => {
  console.log('Servidor iniciado en http://localhost:3000');
});
