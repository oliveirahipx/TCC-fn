const express = require('express');
const path = require('path');
const session = require('express-session');  // Importando o express-session
const app = express();

// Configurações do Express
app.set('view engine', 'ejs');
app.set('views', './app/views');
app.set('public', './public');
app.use(express.static(path.join(__dirname, '../public')));
app.use(express.urlencoded({ extended: true })); 

// Configuração do express-session
app.use(session({
    secret: 'seu-segredo-aqui',  // Substitua por uma chave segura
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false }  // Mudar para true se estiver usando HTTPS
}));

module.exports = app;