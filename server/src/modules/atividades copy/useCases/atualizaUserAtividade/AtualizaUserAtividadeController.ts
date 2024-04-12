import { Request, Response } from "express";
import { AtualizaAtividadeEntregaUseCase, AtualizaAtividadeNotaUseCase } from "./AtualizaUserAtividadeUseCase";

export class AtualizaAtividadeEntregaController {
    async handle(req: Request, res: Response) {
        
        const atualizaAtividadeEntregaUseCase = new AtualizaAtividadeEntregaUseCase();

        const { id, data } = req.body;
        
        const result = await atualizaAtividadeEntregaUseCase.execute(id, data);
        return res.status(201).json(result);
    }
}

export class AtualizaAtividadeNotaController {
    async handle(req: Request, res: Response) {
        
        const atualizaAtividadeNotaUseCase = new AtualizaAtividadeNotaUseCase();

        const { id, nota } = req.body;
        
        const result = await atualizaAtividadeNotaUseCase.execute(id, nota);
        return res.status(201).json(result);
    }
}