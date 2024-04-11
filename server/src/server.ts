import "express-async-errors";
import express, { NextFunction, Request, Response } from 'express';
import { routes } from './routes';
import { AppError } from "./errors/AppErrors";
import { informativo } from "./middlewares";


const app = express();

app.use(express.json());
app.use(routes);



// Função para tratar erros e mostra-lo de forma mais amigável
app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
  if(err instanceof AppError){
    console.log('Erro:');
    console.log(err.message);

    return res.status(err.statusCode).json({
      status: 'error',
      error: err.message
    });
  }

  console.log('Erro:');
  console.log(err.message);

  return res.status(500).json({
    status: 'error',
    message: `Internal Server Error - ${err.message}`
  });
});






// Inicializa o servidor na porta 3000
app.listen(3000, () => {
  console.log('Server is running on http://localhost:3000');
});


// Rota para testar o servidor
app.get('/', informativo, (req, res) => {
  res.send('Hello World');
});
