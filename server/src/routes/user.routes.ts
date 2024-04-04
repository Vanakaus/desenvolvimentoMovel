import { Router } from "express";
import { CreateUserController } from "../modules/users/useCases/createUser/CreateUserController";
import { informativo } from "../middlewares";
import { ListUserController } from "../modules/users/useCases/listUser/ListUserController";



const createUserController  = new CreateUserController();
const listUserController  = new ListUserController();
const userRoutes = Router();


// userRoutes.post('/cria', createUserController.handle);
userRoutes.post('/cria', informativo, createUserController.handle);
userRoutes.get('/listUsers', informativo, listUserController.handle);


export { userRoutes };
