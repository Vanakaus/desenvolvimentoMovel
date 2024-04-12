import { Router } from "express";
import { informativo } from "../middlewares";
import { CriaUserAtividadeController } from "../modules/atividades copy/useCases/criaUserAtividade/CriaUserAtividadeController";



const criaUserAtividadeController  = new CriaUserAtividadeController();
const userAtividadeRoutes = Router();


// Rotas de atividades do usuário
userAtividadeRoutes.post('/cria', informativo, criaUserAtividadeController.handle);
// userAtividadeRoutes.get('/listAtividadeUser', informativo, listUserController.handle);
// userAtividadeRoutes.get('/leAtividadeUser', informativo, listUserController.handle);
// userAtividadeRoutes.patch('/atualizaAtividadeUser', informativo, listUserController.handle);
// userAtividadeRoutes.delete('/deletaAtividadeUser', informativo, listUserController.handle);


export { userAtividadeRoutes };
