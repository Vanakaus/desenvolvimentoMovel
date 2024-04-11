import { Router } from "express";
import { userRoutes } from "./user.routes";
import { atividadeRoutes } from "./atividades.routes";


const routes = Router();


routes.use('/users', userRoutes);
routes.use('/atividades', atividadeRoutes);


export { routes };