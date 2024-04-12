import { Router } from "express";
import { informativo } from "../middlewares";
import { CriaUserAtividadeController } from "../modules/atividades copy/useCases/criaUserAtividade/CriaUserAtividadeController";
import { ListaAtividadesController, ListaUserAtividadeController } from "../modules/atividades copy/useCases/listaUserAtividade/ListaUserAtividadeController";



const criaUserAtividadeController  = new CriaUserAtividadeController();
const listaUserAtividadeController = new ListaUserAtividadeController();
const listaAtividadesController = new ListaAtividadesController();
const userAtividadeRoutes = Router();


// Rotas de atividades do usuário
userAtividadeRoutes.post('/cria', informativo, criaUserAtividadeController.handle);
userAtividadeRoutes.get('/listaUserAtividades', informativo, listaUserAtividadeController.handle);
userAtividadeRoutes.get('/listaAtividades', informativo, listaAtividadesController.handle);
// userAtividadeRoutes.get('/leAtividadeUser', informativo, listUserController.handle);
// userAtividadeRoutes.patch('/atualizaAtividadeUser', informativo, listUserController.handle);
// userAtividadeRoutes.delete('/deletaAtividadeUser', informativo, listUserController.handle);


export { userAtividadeRoutes };
