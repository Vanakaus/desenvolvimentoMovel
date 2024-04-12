import { Request, Response } from "express";
import { CriaUserAtividadeUseCase } from "./CriaUserAtividadeUseCase";

export class CriaUserAtividadeController {
    async handle(req: Request, res: Response) {
        
        const { id_aluno, id_atividade } = req.body;
        const criaUserAtividadeUseCase = new CriaUserAtividadeUseCase();
        
        const result = await criaUserAtividadeUseCase.execute({id_aluno, id_atividade});
        return res.status(201).json(result);
    }
}