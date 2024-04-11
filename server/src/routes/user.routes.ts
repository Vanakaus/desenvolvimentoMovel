import { Router } from "express";
import { informativo } from "../middlewares";
import { CreateUserController } from "../modules/users/useCases/createUser/CreateUserController";
import { ListUserController } from "../modules/users/useCases/listUser/ListUserController";
import { LeUserController } from "../modules/users/useCases/leUser/LeUserController";
import { AtualizaUserController } from "../modules/users/useCases/atualizaUser/AtualizaUserController";
import { DeletaUserController } from "../modules/users/useCases/deletaUser/DeletaUserController";



const createUserController  = new CreateUserController();
const listUserController  = new ListUserController();
const leUserController  = new LeUserController();
const atualizaUserController  = new AtualizaUserController();
const deletaUserController  = new DeletaUserController();
const userRoutes = Router();



// Rotas de Usuários
userRoutes.post('/cria', informativo, createUserController.handle);
userRoutes.get('/listUsers', informativo, listUserController.handle);
userRoutes.get('/leUser', informativo, leUserController.handle);
userRoutes.patch('/atualizaUser', informativo, atualizaUserController.handle);
userRoutes.delete('/deletaUser', informativo, deletaUserController.handle);


export { userRoutes };
