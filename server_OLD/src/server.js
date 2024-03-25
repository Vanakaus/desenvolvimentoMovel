const express = require('express');
const test = require('./test');

const app = express();

app.use(express.json());

const PORT = 3003;

app.listen(PORT, () =>{
    console.clear();
    console.log(`Hello Word! \n ${PORT}`) 
} );


app.get('/', async (req, res) => {
    const query = await test();
    return res.status(201).json(query);
});