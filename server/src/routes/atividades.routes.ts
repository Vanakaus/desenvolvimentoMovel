import { Router } from "express";
import { informativo } from "../middlewares";
import { CriaAtividadeController } from "../modules/atividades/useCases/criaAtividade/CriaAtividadeController";
import { ListaAtividadeController } from "../modules/atividades/useCases/listaAtividade/ListaAtividadeController";
import { LeAtividadeController } from "../modules/atividades/useCases/leAtividade/LeAtividadeController";
import { AtualizaAtividadeController } from "../modules/atividades/useCases/atualizaAtividade/AtualizaAtividadeController";
import { DeletaAtividadeController } from "../modules/atividades/useCases/deletaAtividade/DeletaAtividadeController";



const criaAtividadeController = new CriaAtividadeController();
const listaAtividadeController = new ListaAtividadeController();
const leAtividadeController = new LeAtividadeController();
const atualizaAtividadeController = new AtualizaAtividadeController();
const deletaAtividadeController = new DeletaAtividadeController();
const atividadeRoutes = Router();


// Rotas de Atividades
atividadeRoutes.post('/cria', informativo, criaAtividadeController.handle);
atividadeRoutes.get('/lista', informativo, listaAtividadeController.handle);
atividadeRoutes.get('/le', informativo, leAtividadeController.handle);
atividadeRoutes.patch('/atualiza', informativo, atualizaAtividadeController.handle);
atividadeRoutes.delete('/deleta', informativo, deletaAtividadeController.handle);



export { atividadeRoutes };
