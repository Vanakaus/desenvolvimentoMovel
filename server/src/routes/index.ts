import { Router } from "express";
import { userRoutes } from "./user.routes";
import { atividadeRoutes } from "./atividades.routes";
import { userAtividadeRoutes } from "./userAtividades.routes";


const routes = Router();


routes.use('/users', userRoutes);
routes.use('/atividades', atividadeRoutes);
routes.use('/userAtividades', userAtividadeRoutes);


export { routes };