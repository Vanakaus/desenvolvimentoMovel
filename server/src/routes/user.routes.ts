import { Router } from "express";
import { informativo } from "../middlewares";
import { CreateUserController } from "../modules/users/useCases/createUser/CreateUserController";
import { ListUserController } from "../modules/users/useCases/listUser/ListUserController";



const createUserController  = new CreateUserController();
const listUserController  = new ListUserController();
const userRoutes = Router();



// Rotas de Usuários
userRoutes.post('/cria', informativo, createUserController.handle);
userRoutes.get('/listUsers', informativo, listUserController.handle);
// userRoutes.get('/leUser', informativo, listUserController.handle);
// userRoutes.get('/leUser/:id', informativo, listUserController.handle);
// userRoutes.patch('/atualizaUser', informativo, listUserController.handle);
// userRoutes.patch('/atualizaUser/:id', informativo, listUserController.handle);
// userRoutes.delete('/deletaUser', informativo, listUserController.handle);
// userRoutes.delete('/deletaUser/:id', informativo, listUserController.handle);


export { userRoutes };
