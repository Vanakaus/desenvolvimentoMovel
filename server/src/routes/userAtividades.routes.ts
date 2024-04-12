import { Router } from "express";
import { informativo } from "../middlewares";
import { CriaUserAtividadeController } from "../modules/atividades copy/useCases/criaUserAtividade/CriaUserAtividadeController";
import { ListaAtividadesController, ListaUserAtividadeController } from "../modules/atividades copy/useCases/listaUserAtividade/ListaUserAtividadeController";
import { AtualizaAtividadeEntregaController, AtualizaAtividadeNotaController } from "../modules/atividades copy/useCases/atualizaUserAtividade/AtualizaUserAtividadeController";
import { DeletaUserAtividadeController } from "../modules/atividades copy/useCases/deletaAtividade/DeletaAtividadeController";



const criaUserAtividadeController  = new CriaUserAtividadeController();
const listaUserAtividadeController = new ListaUserAtividadeController();
const listaAtividadesController = new ListaAtividadesController();
const atualizaAtividadeEntregaController = new AtualizaAtividadeEntregaController();
const atualizaAtividadeNotaController = new AtualizaAtividadeNotaController();
const deletaUserAtividadeController = new DeletaUserAtividadeController();
const userAtividadeRoutes = Router();


// Rotas de atividades do usuário
userAtividadeRoutes.post('/cria', informativo, criaUserAtividadeController.handle);
userAtividadeRoutes.get('/listaUserAtividades', informativo, listaUserAtividadeController.handle);
userAtividadeRoutes.get('/listaAtividades', informativo, listaAtividadesController.handle);
userAtividadeRoutes.patch('/atualizaEntrega', informativo, atualizaAtividadeEntregaController.handle);
userAtividadeRoutes.patch('/atualizaNota', informativo, atualizaAtividadeNotaController.handle);
userAtividadeRoutes.delete('/deleta', informativo, deletaUserAtividadeController.handle);


export { userAtividadeRoutes };
