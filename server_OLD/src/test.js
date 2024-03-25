const connection = require('./connection');

const test = async () => {
    const [query] = await connection.execute('SELECT * FROM loja_erick.produtos;');
    return query;
};

module.exports = test;