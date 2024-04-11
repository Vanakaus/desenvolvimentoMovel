import { Router } from "express";
import { informativo } from "../middlewares";
import { CreateUserController } from "../modules/users/useCases/createUser/CreateUserController";
import { ListUserController } from "../modules/users/useCases/listUser/ListUserController";
import { LeUserController } from "../modules/users/useCases/leUser/LeUserController";



const createUserController  = new CreateUserController();
const listUserController  = new ListUserController();
const leUserController  = new LeUserController();
const userRoutes = Router();



// Rotas de Usuários
userRoutes.post('/cria', informativo, createUserController.handle);
userRoutes.get('/listUsers', informativo, listUserController.handle);
userRoutes.get('/leUser', informativo, leUserController.handle);
// userRoutes.patch('/atualizaUser', informativo, listUserController.handle);
// userRoutes.delete('/deletaUser', informativo, listUserController.handle);


export { userRoutes };
