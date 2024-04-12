import { Request, Response } from "express";
import { AtualizaAtividadeUseCase } from "./AtualizaAtividadeUseCase";

export class AtualizaAtividadeController {
    async handle(req: Request, res: Response) {
        
        const atualizaAtividadeUseCase = new AtualizaAtividadeUseCase();

        const { id, titulo, descricao, data } = req.body;
        
        const result = await atualizaAtividadeUseCase.execute(id, titulo, descricao, data);
        return res.status(201).json(result);
    }
}