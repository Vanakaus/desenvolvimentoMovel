import { Request, Response } from "express";
import { DeletaUserAtividadeUseCase } from "./DeletaAtividadeUseCase";

export class DeletaUserAtividadeController {
    async handle(req: Request, res: Response) {
        
        const deletaUserAtividadeUseCase = new DeletaUserAtividadeUseCase();

        const { id } = req.body;
        
        const result = await deletaUserAtividadeUseCase.execute(id);
        return res.status(201).json(result);
    }
}