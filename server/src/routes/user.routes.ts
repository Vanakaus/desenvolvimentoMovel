import { Router } from "express";
import { CreateUserController } from "../modules/users/useCases/createUser/CreateUserController";
import { informativo } from "../middlewares";



const createUserController  = new CreateUserController();
const userRoutes = Router();


// userRoutes.post('/cria', createUserController.handle);
userRoutes.post('/cria', informativo, createUserController.handle);


export { userRoutes };
