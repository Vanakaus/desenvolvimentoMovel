import { Router } from "express";
import { informativo } from "../middlewares";
import { CriaAtividadeController } from "../modules/atividades/useCases/criaAtividade/CriaAtividadeController";
import { ListaAtividadeController } from "../modules/atividades/useCases/listaAtividade/ListaAtividadeController";
import { LeAtividadeController } from "../modules/atividades/useCases/leAtividade/LeAtividadeController";



const criaAtividadeController = new CriaAtividadeController();
const listaAtividadeController = new ListaAtividadeController();
const leAtividadeController = new LeAtividadeController();
const atividadeRoutes = Router();


// Rotas de Atividades
atividadeRoutes.post('/cria', informativo, criaAtividadeController.handle);
atividadeRoutes.get('/lista', informativo, listaAtividadeController.handle);
atividadeRoutes.get('/le', informativo, leAtividadeController.handle);
// atividadeRoutes.patch('/atualizaAtividade', informativo, listUserController.handle);
// atividadeRoutes.delete('/deletaAtividade', informativo, listUserController.handle);



export { atividadeRoutes };
