import { Router } from "express";
import { informativo } from "../middlewares";
import { CriaUserAtividadeController } from "../modules/userAtividades/useCases/criaUserAtividade/CriaUserAtividadeController";
import { ListaAtividadesController, ListaUserAtividadeController, ListaUserAtividadeNaoEntregueController } from "../modules/userAtividades/useCases/listaUserAtividade/ListaUserAtividadeController";
import { AtualizaAtividadeEntregaController, AtualizaAtividadeNotaController } from "../modules/userAtividades/useCases/atualizaUserAtividade/AtualizaUserAtividadeController";
import { DeletaUserAtividadeController } from "../modules/userAtividades/useCases/deletaAtividade/DeletaAtividadeController";
import { autenticacao } from "../middlewares/autenticacao";



const criaUserAtividadeController  = new CriaUserAtividadeController();
const listaUserAtividadeController = new ListaUserAtividadeController();
const listaAtividadesController = new ListaAtividadesController();
const listaUserAtividadeNaoEntregueController = new ListaUserAtividadeNaoEntregueController();
const atualizaAtividadeEntregaController = new AtualizaAtividadeEntregaController();
const atualizaAtividadeNotaController = new AtualizaAtividadeNotaController();
const deletaUserAtividadeController = new DeletaUserAtividadeController();
const userAtividadeRoutes = Router();


// Rotas de atividades do usuário
userAtividadeRoutes.post('/entrega', informativo, autenticacao, criaUserAtividadeController.handle);
userAtividadeRoutes.get('/listaUserAtividades', informativo, listaUserAtividadeController.handle);
userAtividadeRoutes.get('/listaAtividades', informativo, listaAtividadesController.handle);
userAtividadeRoutes.get('/listaAtividadesNaoEntregues', informativo, listaUserAtividadeNaoEntregueController.handle);
userAtividadeRoutes.patch('/atualizaEntrega', informativo, autenticacao, atualizaAtividadeEntregaController.handle);
userAtividadeRoutes.patch('/atualizaNota', informativo, autenticacao, atualizaAtividadeNotaController.handle);
userAtividadeRoutes.delete('/deleta', informativo, deletaUserAtividadeController.handle);


export { userAtividadeRoutes };
