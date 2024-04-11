import { Router } from "express";
import { informativo } from "../middlewares";
import { CriaAtividadeController } from "../modules/atividades/useCases/criaAtividade/CriaAtividadeController";



const criaAtividadeController = new CriaAtividadeController();
const atividadeRoutes = Router();


// Rotas de Atividades
atividadeRoutes.post('/criaAtividade', informativo, criaAtividadeController.handle);
// atividadeRoutes.get('/listAtividade', informativo, listUserController.handle);
// atividadeRoutes.get('/leAtividade', informativo, listUserController.handle);
// atividadeRoutes.patch('/atualizaAtividade', informativo, listUserController.handle);
// atividadeRoutes.delete('/deletaAtividade', informativo, listUserController.handle);



export { atividadeRoutes };
