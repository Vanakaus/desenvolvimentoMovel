import { Request, Response } from "express";
import { DeletaUserUseCase } from "./DeletaUserUseCase";

export class DeletaUserController {
    async handle(req: Request, res: Response) {
        
        const deletaUserUseCase = new DeletaUserUseCase();

        const { id } = req.body;
        
        const result = await deletaUserUseCase.execute(id);
        return res.status(201).json(result);
    }
}