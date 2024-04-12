import { Request, Response } from "express";
import { DeletaAtividadeUseCase } from "./DeletaAtividadeUseCase";

export class DeletaAtividadeController {
    async handle(req: Request, res: Response) {
        
        const deletaAtividadeUseCase = new DeletaAtividadeUseCase();

        const { id } = req.body;
        
        const result = await deletaAtividadeUseCase.execute(id);
        return res.status(201).json(result);
    }
}