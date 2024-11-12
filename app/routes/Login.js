const mysql = require('mysql2'); // Usando mysql2
module.exports = function(app) {


    // Criando o pool de conexões (melhor do que criar uma conexão direta)
    const pool = mysql.createPool({
        host: 'localhost',
        user: 'root',
        password: 'Prof@dm1n',
        database: 'Escola',
        waitForConnections: true,
        connectionLimit: 10,  // Limite de conexões simultâneas
        queueLimit: 0
    });

    // Rota para exibir a página de cadastro de aluno
    app.get('/Login', function(req, res) {
        try {
            pool.query('SELECT * FROM Usuarios', (err, results) => {
                if (err) {
                    console.error('Erro ao consultar o banco de dados: ', err.message);
                    return res.status(500).send('Erro ao consultar o banco de dados');
                }

                // Log para verificar os resultados da consulta
                console.log(results);

                // Renderizando a página EJS com os dados obtidos
                res.render('Login',  { Alunos: results });
            });
        } catch (error) {
            console.error('Erro no aplicativo: ', error);
            res.status(500).send('Erro interno do servidor');
        }
    });




    
    app.post('/Logar', function(req, res) {
        const { email, senha } = req.body;

        // Verificando se todos os dados foram fornecidos
        if (!email || !senha) {
            return res.status(400).send('Todos os campos são obrigatórios');
        }

        pool.query('SELECT * FROM Usuarios', (err, results) => {
            if (err) {
                console.error('Erro ao consultar o banco de dados: ', err.message);
                return res.status(500).send('Erro ao consultar o banco de dados');
            }else if(!email || !senha === email || senha){
                console.log('Login Efetuado')
            }
    

            console.log('Login Efetuado');
            res.redirect('/index'); 
        });
    });

    
};

